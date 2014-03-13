class UtilityController < ApplicationController
require 'pp'
  # 添付ファイルのダウンロード  
  def download
    @attach = Attachment.find(params[:aid])
    ctype = (@attach.contenttype.present? ? @attach.contenttype : 'application/octet-stream')
    send_data(@attach.rawdata, filename: @attach.filename, type: ctype, disposition: (params[:forced] ? :attachment : :inline))
  end

  # 添付ファイルの削除  
  def detach
    @attach = Attachment.find(params[:aid])
    @attach.destroy
  rescue => ex
    render json: { 'result' => 'error',   'message' => ex.message + "\n" + ex.backtrace[0..4].join("\n"), 'detail' => ex.to_s }
  else
    render json: { 'result' => 'success', :aid => params[:aid] } 
  end

  # 添付ファイルアップロードの受け付け  
  # アップロードされたファイルは全てバイナリーデータとしてDBのBLOBカラムに格納する。
  def upload
    stime = Time.now
    exts = {
      '.txt'  => 'text',
      '.doc'  => 'word',
      '.docx' => 'word',
      '.xls'  => 'excel',
      '.xlsx' => 'excel',
      '.pdf'  => 'pdf', 
      '.zip'  => 'zip',
      '.lzh'  => 'zip',
      '.rar'  => 'zip',
      '.png'  => 'image',
      '.gif'  => 'image',
      '.bmp'  => 'image',
      '.jpg'  => 'image',
      '.jpeg' => 'image',
      '.tiff' => 'image',
      '.lnk'  => 'web',
      '.avi'  => 'movie',
      '.mpg'  => 'movie',
      '.mpeg' => 'movie',
      '.flv'  => 'movie',
      '.wmv'  => 'movie',
      '.h246' => 'movie'
    }
    uf = params[:file]
    attparam = {
      :customer_id => params[:customerid],
      :filename    => uf.original_filename,
      :filesize    => uf.size,
      :contenttype => uf.content_type,
      :extension   => ( exts.key?(File.extname(uf.original_filename)) ? exts[File.extname(uf.original_filename)] : 'default' ),
      :rawdata     => uf.read
    }
    @attach = Attachment.new(attparam)
    saved   = @attach.save
    etime   = Time.now

  rescue => ex
    render :json =>  { 'result' => 'error',   'exec_time' => 0, 'message' => ex.message + "\n" + ex.backtrace[0..4].join("\n"), 'detail' => ex.to_s }
  else
    unless saved
      render :json =>  { 'result' => 'success', 'exec_time' => (etime - stime).round(2), 'extension' => @attach.extension, 'id' => @attach.id, 'message' => '' }
    else
      render :json =>  { 'result' => 'error',   'exec_time' => 0, 'message' => 'Failed to save an attachment file.', 'detail' => '' }
    end

#     render :json => (/csv/i =~ File.extname(filename) ? csv_parse_accsta(filepath) : excel_parse_accsta(filepath))
#    render :json => csv_parse_accsta(filepath)   if /csv/i =~ File.extname(filename)
#    render :json => excel_parse_accsta(filepath) if /xls/i =~ File.extname(filename)
    #render :json => params
  end

end
