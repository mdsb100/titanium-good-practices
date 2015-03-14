$.index.open();

$.label.applyProperties( {
  color: "orange",
  font: {
    fontSize: 20
  }
} );

$.submit.addEventListener( "click", function() {
  var name = $.textfield.value; //获得输入的内容
  if ( name == '' || name == null ) {
    alert( "name 不能为空" );
  } else {
    $.namelist.sections[ 0 ].appendItems( [
      {
        name: {
          text: name
        }
      }
    ] );
  }
} );

//点击时删除当前item
$.namelist.addEventListener( "itemclick", function( e ) {
  e.section.deleteItemsAt( e.itemIndex, 1 );
} );