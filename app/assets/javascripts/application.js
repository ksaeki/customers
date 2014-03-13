// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.dialog
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-ja
//= require complete
//= require initcompletion
//= require_tree .

function toggleOptions() {
  $( '#option_button' ).html( $( '#option_button' ).html() == '+' ? '-' : '+' ).attr( 'title', ( $( '#option_button' ).html() == '+' ? 'Show' : 'Hide' ) + ' options.' ); 
  $( '#option_container' ).toggleClass('active');
}

function deSelect() {
  if (window.getSelection)
  {
    var selection = window.getSelection();
    selection.collapse(document.body, 0);
  }
  else
  {
    var selection = document.selection.createRange();
    selection.setEndPoint("EndToStart", selection);
    selection.select();
  }
}

function showDialog(title, message) {
  title = title || 'Message'
  message = message || ''
  $('#modal .message').html(message);
  $('#modal').dialog('option', 'title', title).dialog('open');
}


$(function(){
  $( 'table.result > tbody > tr' ).on('click', function(e) {
    $( 'table.result > tbody > tr' ).removeClass('active');
    $(this).addClass('active');
  });

  $( 'table.result > tbody > tr' ).on('dblclick', function(e) {
    if ($(this).find('.btn_edit').length) {
      document.location = $(this).find('.btn_edit').attr('href');
    }
  });

  $( '#option_button' ).on('click', function(e) {
    toggleOptions();
  });

  $( '#show_more' ).on('click', function(e) {
    $( '#options_removelimit'    ).attr('checked', 'checked'); 
    $( 'form' ).get(0).submit(); 
  });

  $(".messagearea.active").delay(10000).fadeOut();

  $( ".attachment_header .detach" ).on('click', function(e) {
    if ($( ".dropzone .dz-preview").is(".active" )) {
      if (window.confirm( "Are you sure?" )) {
        $.ajax({
            "url" : "/detach/" + $( ".dropzone .dz-preview.active" ).data('id'),
            "type" : "DELEtE",
            "cache" : false,
            "dataType" : "json",
            "success" : function(result) {
              if (result.result == 'success') {
                $( ".dropzone .dz-preview[data-id='" + result.aid + "']" ).remove();
              } else {
                alert(result.message);
              }
            },
            "error" : function(result) {
              alert("Un error occured.");
            }
        });
      }
    }
  });
  $( ".attachment_header .download" ).on('click', function(e) {
    if ($( ".dropzone .dz-preview").is(".active" )) {
      document.location.href = '/download/' + $( ".dropzone .dz-preview.active" ).data('id') + '/true';
    }
  });

  $( ".dropzone" ).on({
    'click': function(e) {
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      $('.selected-filename').html($(this).attr('title'));
    },
    'dblclick': function(e) {
      document.location.href = '/download/' + $(this).data('id')
    }},
    '.dz-preview'
  );
//  if ( $('#options_incomplete').attr('checked') || $('#options_removelimit').attr('checked') ) {
//      toggleOptions();
//  }

  // ---------------------------------------
  // モーダルダイアログボックスの設定
  // ---------------------------------------
  $('#modal').dialog({
    autoOpen: false,  // 自動でオープンしない
    modal: true,      // モーダル表示する
    resizable: false, // リサイズしない
    draggable: false, // ドラッグしない
    show: "clip",     // 表示時のエフェクト
    hide: "fade",     // 非表示時のエフェクト
    buttons: [{ 
      text: "Ok", 
      click: function() { $( this ).dialog( "close" ); } 
    }]
  });

});
