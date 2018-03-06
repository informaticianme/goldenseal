class CurationConcerns::VideosController < ApplicationController
  include CurationConcerns::CurationConcernController
  
  include AttachFiles
  before_filter :add_attachments_to_files, only: :create

  set_curation_concern_type Video

  def show_presenter
    ::VideoPresenter
  end

  delegate :prevent_download, to: :solr_document
end
