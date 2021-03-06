



(function(window, document, undefined) {



function fnInvertKeyValues( aIn )
{
	var aRet=[];
	for ( var i=0, iLen=aIn.length ; i<iLen ; i++ )
	{
		aRet[ aIn[i] ] = i;
	}
	return aRet;
}



function fnArraySwitch( aArray, iFrom, iTo )
{
	var mStore = aArray.splice( iFrom, 1 )[0];
	aArray.splice( iTo, 0, mStore );
}



function fnDomSwitch( nParent, iFrom, iTo )
{
	var anTags = [];
	for ( var i=0, iLen=nParent.childNodes.length ; i<iLen ; i++ )
	{
		if ( nParent.childNodes[i].nodeType == 1 )
		{
			anTags.push( nParent.childNodes[i] );
		}
	}
	var nStore = anTags[ iFrom ];

	if ( iTo !== null )
	{
		nParent.insertBefore( nStore, anTags[iTo] );
	}
	else
	{
		nParent.appendChild( nStore );
	}
}



var factory = function( $, DataTable ) {
"use strict";


$.fn.dataTableExt.oApi.fnColReorder = function ( oSettings, iFrom, iTo )
{
	var v110 = $.fn.dataTable.Api ? true : false;
	var i, iLen, j, jLen, iCols=oSettings.aoColumns.length, nTrs, oCol;
	var attrMap = function ( obj, prop, mapping ) {
		if ( ! obj[ prop ] ) {
			return;
		}

		var a = obj[ prop ].split('.');
		var num = a.shift();

		if ( isNaN( num*1 ) ) {
			return;
		}

		obj[ prop ] = mapping[ num*1 ]+'.'+a.join('.');
	};

	
	if ( iFrom == iTo )
	{
		
		return;
	}

	if ( iFrom < 0 || iFrom >= iCols )
	{
		this.oApi._fnLog( oSettings, 1, "ColReorder 'from' index is out of bounds: "+iFrom );
		return;
	}

	if ( iTo < 0 || iTo >= iCols )
	{
		this.oApi._fnLog( oSettings, 1, "ColReorder 'to' index is out of bounds: "+iTo );
		return;
	}

	
	var aiMapping = [];
	for ( i=0, iLen=iCols ; i<iLen ; i++ )
	{
		aiMapping[i] = i;
	}
	fnArraySwitch( aiMapping, iFrom, iTo );
	var aiInvertMapping = fnInvertKeyValues( aiMapping );


	
	
	for ( i=0, iLen=oSettings.aaSorting.length ; i<iLen ; i++ )
	{
		oSettings.aaSorting[i][0] = aiInvertMapping[ oSettings.aaSorting[i][0] ];
	}

	
	if ( oSettings.aaSortingFixed !== null )
	{
		for ( i=0, iLen=oSettings.aaSortingFixed.length ; i<iLen ; i++ )
		{
			oSettings.aaSortingFixed[i][0] = aiInvertMapping[ oSettings.aaSortingFixed[i][0] ];
		}
	}

	
	for ( i=0, iLen=iCols ; i<iLen ; i++ )
	{
		oCol = oSettings.aoColumns[i];
		for ( j=0, jLen=oCol.aDataSort.length ; j<jLen ; j++ )
		{
			oCol.aDataSort[j] = aiInvertMapping[ oCol.aDataSort[j] ];
		}

		// Update the column indexes
		if ( v110 ) {
			oCol.idx = aiInvertMapping[ oCol.idx ];
		}
	}

	if ( v110 ) {
		// Update 1.10 optimised sort class removal variable
		$.each( oSettings.aLastSort, function (i, val) {
			oSettings.aLastSort[i].src = aiInvertMapping[ val.src ];
		} );
	}

	
	for ( i=0, iLen=iCols ; i<iLen ; i++ )
	{
		oCol = oSettings.aoColumns[i];

		if ( typeof oCol.mData == 'number' ) {
			oCol.mData = aiInvertMapping[ oCol.mData ];

			// regenerate the get / set functions
			oSettings.oApi._fnColumnOptions( oSettings, i, {} );
		}
		else if ( $.isPlainObject( oCol.mData ) ) {
			// HTML5 data sourced
			attrMap( oCol.mData, '_',      aiInvertMapping );
			attrMap( oCol.mData, 'filter', aiInvertMapping );
			attrMap( oCol.mData, 'sort',   aiInvertMapping );
			attrMap( oCol.mData, 'type',   aiInvertMapping );

			// regenerate the get / set functions
			oSettings.oApi._fnColumnOptions( oSettings, i, {} );
		}
	}


	
	if ( oSettings.aoColumns[iFrom].bVisible )
	{
		
		var iVisibleIndex = this.oApi._fnColumnIndexToVisible( oSettings, iFrom );
		var iInsertBeforeIndex = null;

		i = iTo < iFrom ? iTo : iTo + 1;
		while ( iInsertBeforeIndex === null && i < iCols )
		{
			iInsertBeforeIndex = this.oApi._fnColumnIndexToVisible( oSettings, i );
			i++;
		}

		
		nTrs = oSettings.nTHead.getElementsByTagName('tr');
		for ( i=0, iLen=nTrs.length ; i<iLen ; i++ )
		{
			fnDomSwitch( nTrs[i], iVisibleIndex, iInsertBeforeIndex );
		}

		
		if ( oSettings.nTFoot !== null )
		{
			nTrs = oSettings.nTFoot.getElementsByTagName('tr');
			for ( i=0, iLen=nTrs.length ; i<iLen ; i++ )
			{
				fnDomSwitch( nTrs[i], iVisibleIndex, iInsertBeforeIndex );
			}
		}

		
		for ( i=0, iLen=oSettings.aoData.length ; i<iLen ; i++ )
		{
			if ( oSettings.aoData[i].nTr !== null )
			{
				fnDomSwitch( oSettings.aoData[i].nTr, iVisibleIndex, iInsertBeforeIndex );
			}
		}
	}

	
	
	fnArraySwitch( oSettings.aoColumns, iFrom, iTo );

	
	fnArraySwitch( oSettings.aoPreSearchCols, iFrom, iTo );

	
	for ( i=0, iLen=oSettings.aoData.length ; i<iLen ; i++ )
	{
		var data = oSettings.aoData[i];

		if ( v110 ) {
			// DataTables 1.10+
			if ( data.anCells ) {
				fnArraySwitch( data.anCells, iFrom, iTo );
			}

			// For DOM sourced data, the invalidate will reread the cell into
			// the data array, but for data sources as an array, they need to
			// be flipped
			if ( data.src !== 'dom' && $.isArray( data._aData ) ) {
				fnArraySwitch( data._aData, iFrom, iTo );
			}
		}
		else {
			// DataTables 1.9-
			if ( $.isArray( data._aData ) ) {
				fnArraySwitch( data._aData, iFrom, iTo );
			}
			fnArraySwitch( data._anHidden, iFrom, iTo );
		}
	}

	
	for ( i=0, iLen=oSettings.aoHeader.length ; i<iLen ; i++ )
	{
		fnArraySwitch( oSettings.aoHeader[i], iFrom, iTo );
	}

	if ( oSettings.aoFooter !== null )
	{
		for ( i=0, iLen=oSettings.aoFooter.length ; i<iLen ; i++ )
		{
			fnArraySwitch( oSettings.aoFooter[i], iFrom, iTo );
		}
	}

	// In 1.10 we need to invalidate row cached data for sorting, filtering etc
	if ( v110 ) {
		var api = new $.fn.dataTable.Api( oSettings );
		api.rows().invalidate();
	}

	

	
	for ( i=0, iLen=iCols ; i<iLen ; i++ )
	{
		$(oSettings.aoColumns[i].nTh).off('click.DT');
		this.oApi._fnSortAttachListener( oSettings, oSettings.aoColumns[i].nTh, i );
	}


	
	$(oSettings.oInstance).trigger( 'column-reorder', [ oSettings, {
		"iFrom": iFrom,
		"iTo": iTo,
		"aiInvertMapping": aiInvertMapping
	} ] );
};



var ColReorder = function( dt, opts )
{
	var oDTSettings;

	if ( $.fn.dataTable.Api ) {
		oDTSettings = new $.fn.dataTable.Api( dt ).settings()[0];
	}
	// 1.9 compatibility
	else if ( dt.fnSettings ) {
		// DataTables object, convert to the settings object
		oDTSettings = dt.fnSettings();
	}
	else if ( typeof dt === 'string' ) {
		// jQuery selector
		if ( $.fn.dataTable.fnIsDataTable( $(dt)[0] ) ) {
			oDTSettings = $(dt).eq(0).dataTable().fnSettings();
		}
	}
	else if ( dt.nodeName && dt.nodeName.toLowerCase() === 'table' ) {
		// Table node
		if ( $.fn.dataTable.fnIsDataTable( dt.nodeName ) ) {
			oDTSettings = $(dt.nodeName).dataTable().fnSettings();
		}
	}
	else if ( dt instanceof jQuery ) {
		// jQuery object
		if ( $.fn.dataTable.fnIsDataTable( dt[0] ) ) {
			oDTSettings = dt.eq(0).dataTable().fnSettings();
		}
	}
	else {
		// DataTables settings object
		oDTSettings = dt;
	}

	// Ensure that we can't initialise on the same table twice
	if ( oDTSettings._colReorder ) {
		throw "ColReorder already initialised on table #"+oDTSettings.nTable.id;
	}

	// Convert from camelCase to Hungarian, just as DataTables does
	var camelToHungarian = $.fn.dataTable.camelToHungarian;
	if ( camelToHungarian ) {
		camelToHungarian( ColReorder.defaults, ColReorder.defaults, true );
		camelToHungarian( ColReorder.defaults, opts || {} );
	}


	

	
	this.s = {
		
		"dt": null,

		
		"init": $.extend( true, {}, ColReorder.defaults, opts ),

		
		"fixed": 0,

		
		"fixedRight": 0,

		
		"reorderCallback": null,

		
		"mouse": {
			"startX": -1,
			"startY": -1,
			"offsetX": -1,
			"offsetY": -1,
			"target": -1,
			"targetIndex": -1,
			"fromIndex": -1
		},

		
		"aoTargets": []
	};


	
	this.dom = {
		
		"drag": null,

		
		"pointer": null
	};


	
	this.s.dt = oDTSettings;
	this.s.dt._colReorder = this;
	this._fnConstruct();

	
	oDTSettings.oApi._fnCallbackReg(oDTSettings, 'aoDestroyCallback', $.proxy(this._fnDestroy, this), 'ColReorder');

	return this;
};



ColReorder.prototype = {
	

	
	"fnReset": function ()
	{
		var a = [];
		for ( var i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
		{
			a.push( this.s.dt.aoColumns[i]._ColReorder_iOrigCol );
		}

		this._fnOrderColumns( a );

		return this;
	},

	
	"fnGetCurrentOrder": function ()
	{
		return this.fnOrder();
	},

	
	"fnOrder": function ( set )
	{
		if ( set === undefined )
		{
			var a = [];
			for ( var i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
			{
				a.push( this.s.dt.aoColumns[i]._ColReorder_iOrigCol );
			}
			return a;
		}

		this._fnOrderColumns( fnInvertKeyValues( set ) );

		return this;
	},


	

	
	"_fnConstruct": function ()
	{
		var that = this;
		var iLen = this.s.dt.aoColumns.length;
		var i;

		
		if ( this.s.init.iFixedColumns )
		{
			this.s.fixed = this.s.init.iFixedColumns;
		}

		
		this.s.fixedRight = this.s.init.iFixedColumnsRight ?
			this.s.init.iFixedColumnsRight :
			0;

		
		if ( this.s.init.fnReorderCallback )
		{
			this.s.reorderCallback = this.s.init.fnReorderCallback;
		}

		
		for ( i = 0; i < iLen; i++ )
		{
			if ( i > this.s.fixed-1 && i < iLen - this.s.fixedRight )
			{
				this._fnMouseListener( i, this.s.dt.aoColumns[i].nTh );
			}

			
			this.s.dt.aoColumns[i]._ColReorder_iOrigCol = i;
		}

		
		this.s.dt.oApi._fnCallbackReg( this.s.dt, 'aoStateSaveParams', function (oS, oData) {
			that._fnStateSave.call( that, oData );
		}, "ColReorder_State" );

		
		var aiOrder = null;
		if ( this.s.init.aiOrder )
		{
			aiOrder = this.s.init.aiOrder.slice();
		}

		
		if ( this.s.dt.oLoadedState && typeof this.s.dt.oLoadedState.ColReorder != 'undefined' &&
		  this.s.dt.oLoadedState.ColReorder.length == this.s.dt.aoColumns.length )
		{
			aiOrder = this.s.dt.oLoadedState.ColReorder;
		}

		
		if ( aiOrder )
		{
			
			if ( !that.s.dt._bInitComplete )
			{
				var bDone = false;
				this.s.dt.aoDrawCallback.push( {
					"fn": function () {
						if ( !that.s.dt._bInitComplete && !bDone )
						{
							bDone = true;
							var resort = fnInvertKeyValues( aiOrder );
							that._fnOrderColumns.call( that, resort );
						}
					},
					"sName": "ColReorder_Pre"
				} );
			}
			else
			{
				var resort = fnInvertKeyValues( aiOrder );
				that._fnOrderColumns.call( that, resort );
			}
		}
		else {
			this._fnSetColumnIndexes();
		}
	},


	
	"_fnOrderColumns": function ( a )
	{
		if ( a.length != this.s.dt.aoColumns.length )
		{
			this.s.dt.oInstance.oApi._fnLog( this.s.dt, 1, "ColReorder - array reorder does not "+
				"match known number of columns. Skipping." );
			return;
		}

		for ( var i=0, iLen=a.length ; i<iLen ; i++ )
		{
			var currIndex = $.inArray( i, a );
			if ( i != currIndex )
			{
				
				fnArraySwitch( a, currIndex, i );

				
				this.s.dt.oInstance.fnColReorder( currIndex, i );
			}
		}

		
		if ( this.s.dt.oScroll.sX !== "" || this.s.dt.oScroll.sY !== "" )
		{
			this.s.dt.oInstance.fnAdjustColumnSizing( false );
		}

		
		this.s.dt.oInstance.oApi._fnSaveState( this.s.dt );

		this._fnSetColumnIndexes();
		
		if ( this.s.reorderCallback !== null )
		{
			this.s.reorderCallback.call( this );
		}
	},


	
	"_fnStateSave": function ( oState )
	{
		var i, iLen, aCopy, iOrigColumn;
		var oSettings = this.s.dt;
		var columns = oSettings.aoColumns;

		oState.ColReorder = [];

		
		if ( oState.aaSorting ) {
			// 1.10.0-
			for ( i=0 ; i<oState.aaSorting.length ; i++ ) {
				oState.aaSorting[i][0] = columns[ oState.aaSorting[i][0] ]._ColReorder_iOrigCol;
			}

			var aSearchCopy = $.extend( true, [], oState.aoSearchCols );

			for ( i=0, iLen=columns.length ; i<iLen ; i++ )
			{
				iOrigColumn = columns[i]._ColReorder_iOrigCol;

				
				oState.aoSearchCols[ iOrigColumn ] = aSearchCopy[i];

				
				oState.abVisCols[ iOrigColumn ] = columns[i].bVisible;

				
				oState.ColReorder.push( iOrigColumn );
			}
		}
		else if ( oState.order ) {
			// 1.10.1+
			for ( i=0 ; i<oState.order.length ; i++ ) {
				oState.order[i][0] = columns[ oState.order[i][0] ]._ColReorder_iOrigCol;
			}

			var stateColumnsCopy = $.extend( true, [], oState.columns );

			for ( i=0, iLen=columns.length ; i<iLen ; i++ )
			{
				iOrigColumn = columns[i]._ColReorder_iOrigCol;

				
				oState.columns[ iOrigColumn ] = stateColumnsCopy[i];

				
				oState.ColReorder.push( iOrigColumn );
			}
		}
	},


	

	
	"_fnMouseListener": function ( i, nTh )
	{
		var that = this;
		$(nTh).on( 'mousedown.ColReorder', function (e) {
			e.preventDefault();
			that._fnMouseDown.call( that, e, nTh );
		} );
	},


	
	"_fnMouseDown": function ( e, nTh )
	{
		var that = this;

		
		var target = $(e.target).closest('th, td');
		var offset = target.offset();
		var idx = parseInt( $(nTh).attr('data-column-index'), 10 );

		if ( idx === undefined ) {
			return;
		}

		this.s.mouse.startX = e.pageX;
		this.s.mouse.startY = e.pageY;
		this.s.mouse.offsetX = e.pageX - offset.left;
		this.s.mouse.offsetY = e.pageY - offset.top;
		this.s.mouse.target = this.s.dt.aoColumns[ idx ].nTh;//target[0];
		this.s.mouse.targetIndex = idx;
		this.s.mouse.fromIndex = idx;

		this._fnRegions();

		
		$(document)
			.on( 'mousemove.ColReorder', function (e) {
				that._fnMouseMove.call( that, e );
			} )
			.on( 'mouseup.ColReorder', function (e) {
				that._fnMouseUp.call( that, e );
			} );
	},


	
	"_fnMouseMove": function ( e )
	{
		var that = this;

		if ( this.dom.drag === null )
		{
			
			if ( Math.pow(
				Math.pow(e.pageX - this.s.mouse.startX, 2) +
				Math.pow(e.pageY - this.s.mouse.startY, 2), 0.5 ) < 5 )
			{
				return;
			}
			this._fnCreateDragNode();
		}

		
		this.dom.drag.css( {
			left: e.pageX - this.s.mouse.offsetX,
			top: e.pageY - this.s.mouse.offsetY
		} );

		
		var bSet = false;
		var lastToIndex = this.s.mouse.toIndex;

		for ( var i=1, iLen=this.s.aoTargets.length ; i<iLen ; i++ )
		{
			if ( e.pageX < this.s.aoTargets[i-1].x + ((this.s.aoTargets[i].x-this.s.aoTargets[i-1].x)/2) )
			{
				this.dom.pointer.css( 'left', this.s.aoTargets[i-1].x );
				this.s.mouse.toIndex = this.s.aoTargets[i-1].to;
				bSet = true;
				break;
			}
		}

		// The insert element wasn't positioned in the array (less than
		// operator), so we put it at the end
		if ( !bSet )
		{
			this.dom.pointer.css( 'left', this.s.aoTargets[this.s.aoTargets.length-1].x );
			this.s.mouse.toIndex = this.s.aoTargets[this.s.aoTargets.length-1].to;
		}

		// Perform reordering if realtime updating is on and the column has moved
		if ( this.s.init.bRealtime && lastToIndex !== this.s.mouse.toIndex ) {
			this.s.dt.oInstance.fnColReorder( this.s.mouse.fromIndex, this.s.mouse.toIndex );
			this.s.mouse.fromIndex = this.s.mouse.toIndex;
			this._fnRegions();
		}
	},


	
	"_fnMouseUp": function ( e )
	{
		var that = this;

		$(document).off( 'mousemove.ColReorder mouseup.ColReorder' );

		if ( this.dom.drag !== null )
		{
			
			this.dom.drag.remove();
			this.dom.pointer.remove();
			this.dom.drag = null;
			this.dom.pointer = null;

			
			this.s.dt.oInstance.fnColReorder( this.s.mouse.fromIndex, this.s.mouse.toIndex );
			this._fnSetColumnIndexes();

			
			if ( this.s.dt.oScroll.sX !== "" || this.s.dt.oScroll.sY !== "" )
			{
				this.s.dt.oInstance.fnAdjustColumnSizing( false );
			}

			
			this.s.dt.oInstance.oApi._fnSaveState( this.s.dt );

			if ( this.s.reorderCallback !== null )
			{
				this.s.reorderCallback.call( this );
			}
		}
	},


	
	"_fnRegions": function ()
	{
		var aoColumns = this.s.dt.aoColumns;

		this.s.aoTargets.splice( 0, this.s.aoTargets.length );

		this.s.aoTargets.push( {
			"x":  $(this.s.dt.nTable).offset().left,
			"to": 0
		} );

		var iToPoint = 0;
		for ( var i=0, iLen=aoColumns.length ; i<iLen ; i++ )
		{
			
			if ( i != this.s.mouse.fromIndex )
			{
				iToPoint++;
			}

			if ( aoColumns[i].bVisible )
			{
				this.s.aoTargets.push( {
					"x":  $(aoColumns[i].nTh).offset().left + $(aoColumns[i].nTh).outerWidth(),
					"to": iToPoint
				} );
			}
		}

		
		if ( this.s.fixedRight !== 0 )
		{
			this.s.aoTargets.splice( this.s.aoTargets.length - this.s.fixedRight );
		}

		
		if ( this.s.fixed !== 0 )
		{
			this.s.aoTargets.splice( 0, this.s.fixed );
		}
	},


	
	"_fnCreateDragNode": function ()
	{
		var scrolling = this.s.dt.oScroll.sX !== "" || this.s.dt.oScroll.sY !== "";

		var origCell = this.s.dt.aoColumns[ this.s.mouse.targetIndex ].nTh;
		var origTr = origCell.parentNode;
		var origThead = origTr.parentNode;
		var origTable = origThead.parentNode;
		var cloneCell = $(origCell).clone();

		// This is a slightly odd combination of jQuery and DOM, but it is the
		// fastest and least resource intensive way I could think of cloning
		// the table with just a single header cell in it.
		this.dom.drag = $(origTable.cloneNode(false))
			.addClass( 'DTCR_clonedTable' )
			.append(
				$(origThead.cloneNode(false)).append(
					$(origTr.cloneNode(false)).append(
						cloneCell[0]
					)
				)
			)
			.css( {
				position: 'absolute',
				top: 0,
				left: 0,
				width: $(origCell).outerWidth(),
				height: $(origCell).outerHeight()
			} )
			.appendTo( 'body' );

		this.dom.pointer = $('<div></div>')
			.addClass( 'DTCR_pointer' )
			.css( {
				position: 'absolute',
				top: scrolling ?
					$('div.dataTables_scroll', this.s.dt.nTableWrapper).offset().top :
					$(this.s.dt.nTable).offset().top,
				height : scrolling ?
					$('div.dataTables_scroll', this.s.dt.nTableWrapper).height() :
					$(this.s.dt.nTable).height()
			} )
			.appendTo( 'body' );
	},

	
	"_fnDestroy": function ()
	{
		var i, iLen;

		for ( i=0, iLen=this.s.dt.aoDrawCallback.length ; i<iLen ; i++ )
		{
			if ( this.s.dt.aoDrawCallback[i].sName === 'ColReorder_Pre' )
			{
				this.s.dt.aoDrawCallback.splice( i, 1 );
				break;
			}
		}

		$(this.s.dt.nTHead).find( '*' ).off( '.ColReorder' );

		$.each( this.s.dt.aoColumns, function (i, column) {
			$(column.nTh).removeAttr('data-column-index');
		} );

		this.s.dt._colReorder = null;
		this.s = null;
	},


	
	"_fnSetColumnIndexes": function ()
	{
		$.each( this.s.dt.aoColumns, function (i, column) {
			$(column.nTh).attr('data-column-index', i);
		} );
	}
};









ColReorder.defaults = {
	
	aiOrder: null,

	
	bRealtime: false,

	
	iFixedColumns: 0,

	
	iFixedColumnsRight: 0,

	
	fnReorderCallback: null
};






ColReorder.version = "1.1.3";





// Expose
$.fn.dataTable.ColReorder = ColReorder;
$.fn.DataTable.ColReorder = ColReorder;


// Register a new feature with DataTables
if ( typeof $.fn.dataTable == "function" &&
     typeof $.fn.dataTableExt.fnVersionCheck == "function" &&
     $.fn.dataTableExt.fnVersionCheck('1.9.3') )
{
	$.fn.dataTableExt.aoFeatures.push( {
		"fnInit": function( settings ) {
			var table = settings.oInstance;

			if ( ! settings._colReorder ) {
				var dtInit = settings.oInit;
				var opts = dtInit.colReorder || dtInit.oColReorder || {};

				new ColReorder( settings, opts );
			}
			else {
				table.oApi._fnLog( settings, 1, "ColReorder attempted to initialise twice. Ignoring second" );
			}

			return null; 
		},
		"cFeature": "R",
		"sFeature": "ColReorder"
	} );
}
else {
	alert( "Warning: ColReorder requires DataTables 1.9.3 or greater - www.datatables.net/download");
}


// API augmentation
if ( $.fn.dataTable.Api ) {
	$.fn.dataTable.Api.register( 'colReorder.reset()', function () {
		return this.iterator( 'table', function ( ctx ) {
			ctx._colReorder.fnReset();
		} );
	} );

	$.fn.dataTable.Api.register( 'colReorder.order()', function ( set ) {
		if ( set ) {
			return this.iterator( 'table', function ( ctx ) {
				ctx._colReorder.fnOrder( set );
			} );
		}

		return this.context.length ?
			this.context[0]._colReorder.fnOrder() :
			null;
	} );
}

return ColReorder;
}; // /factory


// Define as an AMD module if possible
if ( typeof define === 'function' && define.amd ) {
	define( ['jquery', 'datatables'], factory );
}
else if ( typeof exports === 'object' ) {
    // Node/CommonJS
    factory( require('jquery'), require('datatables') );
}
else if ( jQuery && !jQuery.fn.dataTable.ColReorder ) {
	// Otherwise simply initialise as normal, stopping multiple evaluation
	factory( jQuery, jQuery.fn.dataTable );
}


})(window, document);
