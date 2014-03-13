//= require dropzone
//= require_self
var totalsize = 0;
var totalproc = 0;
var starttime = 0;
var totalcount = 0;
var indexcount = 0;

function checkFinish(){
    if ($('#dropbox .dz-preview').size() == 0) {
        showDialogMessage('インポート完了', 'データの取り込みが完了しました。');
    }
}

$(function(){
    
    // ---------------------------------------
    // ドロップゾーンの設定
    // ---------------------------------------
    if ($("#dropbox").length == 0) return false;

    Dropzone.autoDiscover = false;
    var myDropzone = new Dropzone("#dropbox",{
        url: '/upload',
        paramName: 'file',
        maxFilesize:16,
        clickable: false,
//        uploadMultiple: true,
        createImageThumbnails: false,
//        parallelUploads: 1,
        maxThumbnailFilesize: 1,
        maxFilesize: 64,
        dictDefaultMessage: "",
        params: {
          customerid: $('form:first [name=id]').val(),
          authenticity_token: $('form:first [name=authenticity_token]').val()
        },
        init: function() {
          this.on("uploadprogress", function(file, progress) {
            console.log("File progress", progress);
          });
        }
    });
    //myDropzone.options.previewTemplate = '<div class="preview file-preview">  <div class="details"></div> <div class="filename"><span data-dz-name></span></div> <div class="progress"><span class="load"></span><span class="upload"></span></div>  <div class="error-message"><span></span></div>  <div class="color"></div></div>'; 
/*
    // テスト用
    myDropzone.on("drop"                   ,function(param1, param2, param3){ console.log(["drop"               , param1, param2, param3]); });
    myDropzone.on("dragstart"              ,function(param1, param2, param3){ console.log(["dragstart"          , param1, param2, param3]); });
    myDropzone.on("dragend"                ,function(param1, param2, param3){ console.log(["dragend"            , param1, param2, param3]); });
    myDropzone.on("dragenter"              ,function(param1, param2, param3){ console.log(["dragenter"          , param1, param2, param3]); });
    myDropzone.on("dragover"               ,function(param1, param2, param3){ console.log(["dragover"           , param1, param2, param3]); });
    myDropzone.on("dragleave"              ,function(param1, param2, param3){ console.log(["dragleave"          , param1, param2, param3]); });
    myDropzone.on("addedfile"              ,function(param1, param2, param3){ console.log(["addedfile"          , param1, param2, param3]); });
    myDropzone.on("removedfile"            ,function(param1, param2, param3){ console.log(["removedfile"        , param1, param2, param3]); });
    myDropzone.on("selectedfiles"          ,function(param1, param2, param3){ console.log(["selectedfiles"      , param1, param2, param3]); });
    myDropzone.on("thumbnail"              ,function(param1, param2, param3){ console.log(["thumbnail"          , param1, param2, param3]); });
    myDropzone.on("error"                  ,function(param1, param2, param3){ console.log(["error"              , param1, param2, param3]); });
    myDropzone.on("processing"             ,function(param1, param2, param3){ console.log(["processing"         , param1, param2, param3]); });
    myDropzone.on("uploadprogress"         ,function(param1, param2, param3){ console.log(["uploadprogress"     , param1, param2, param3]); });
    myDropzone.on("sending"                ,function(param1, param2, param3){ console.log(["sending"            , param1, param2, param3]); });
    myDropzone.on("success"                ,function(param1, param2, param3){ console.log(["success"            , param1, param2, param3]); });
    myDropzone.on("complete"               ,function(param1, param2, param3){ console.log(["complete"           , param1, param2, param3]); });
    myDropzone.on("canceled"               ,function(param1, param2, param3){ console.log(["canceled"           , param1, param2, param3]); });
    myDropzone.on("maxfilesexceeded"       ,function(param1, param2, param3){ console.log(["maxfilesexceeded"   , param1, param2, param3]); });
    myDropzone.on("processingmultiple"     ,function(param1, param2, param3){ console.log(["processingmultiple" , param1, param2, param3]); });
    myDropzone.on("sendingmultiple"        ,function(param1, param2, param3){ console.log(["sendingmultiple"    , param1, param2, param3]); });
    myDropzone.on("successmultiple"        ,function(param1, param2, param3){ console.log(["successmultiple"    , param1, param2, param3]); });
    myDropzone.on("completemultiple"       ,function(param1, param2, param3){ console.log(["completemultiple"   , param1, param2, param3]); });
    myDropzone.on("canceledmultiple"       ,function(param1, param2, param3){ console.log(["canceledmultiple"   , param1, param2, param3]); });
    myDropzone.on("totaluploadprogress"    ,function(param1, param2, param3){ console.log(["totaluploadprogress", param1, param2, param3]); });
    myDropzone.on("reset"                  ,function(param1, param2, param3){ console.log(["reset"              , param1, param2, param3]); });

    myDropzone.on("selectedfiles"          ,function(param1, param2, param3){ 
      console.log(["selectedfiles"      , param1, param2, param3]); 
    });
*/

    // ファイルがドロップされた時
    myDropzone.on("drop",function(param1, param2, param3){
            totalsize = 0;
            totalproc = 0;
            ttl_proc = 0;
            starttime = 0;
            totalcount = 0;
            indexcount = 0;
            starttime = new Date();
            $('#totalProgress .bar').width('0%');
            $('#success,#failed,#result').empty();
        //console.log(['drop', param1, param2, param3, this.filesQueue.length, this.filesProcessing.length]);
    });
    
    // ファイルがリストに追加された時
    myDropzone.on("addedfile",function(file){ 
        totalcount++;
    });
    
    // アップロードの進捗状況変更
    myDropzone.on("uploadprogress",function(file, progress, bytesSent){
        if (progress == 100) {
            $(file.previewElement).find('.dz-details').addClass('analyzing');
        }
        //$(".color").remove();
    });
    
    // 全体の進捗
    myDropzone.on("totaluploadprogress",function(progress, totalbyte, uploaded){
        currenttime = new Date();
        elapsedtime = (currenttime - starttime)
        remainingtime = (elapsedtime / progress) * (100 - progress) / 1000

        $('#totalProgress .bar').width(progress + '%');
        $('#countProgress').html('[ ' + indexcount + ' / ' + totalcount + ' ]');
        $('#remainingTime').html('残り ' + Math.round(remainingtime) + ' 秒');
    });
    
    // POSTの通信成功時
    myDropzone.on("success",function(file,result){ // (送信したファイルの情報,カラーコードのJSONデータ)
        // 対象から analyzing クラスを外してローディングアニメーションをを非表示に
        if (result.result = 'success') {
          $(file.previewElement)
            .find('.dz-details')
            .removeClass('analyzing')
            .addClass(result.extension);

          $(file.previewElement)
            .find('.dz-progress')
            .hide();

          $(file.previewElement)
            .attr('rel', 'popover')
            .attr('data-original-title', 'err')
            .attr('data-content', result.message)
            .attr('data-id', result.id)
            .attr('title', file.name)
            .attr('data-trigger', 'hover')
            .attr('data-placement', 'bottom')
            .addClass(result.extension);

          totalproc += file.size;
        } else {
          showDialog('Error', result.message);
        }
    });
    
    // POSTの通信失敗時
    myDropzone.on("error",function(file,result){ // (送信したファイルの情報,カラーコードのJSONデータ)
      showDialog('Error', 'Unknown error occurred.');
      $(file.previewElement).remove();
        // 対象から analyzing クラスを外してローディングアニメーションをを非表示に
        //$(file.previewElement).find('.dz-details').removeClass('analyzing');

        //totalproc += file.size;
    });
    
    // POSTの通信完了時(success/errorの後)
    myDropzone.on("complete",function(file){ 
        indexcount++;
        $('#countProgress').html('[ ' + indexcount + ' / ' + totalcount + ' ]');
    });
});
