module CurationConcerns
  class TextForm < TeiForm
    self.model_class = ::Text
    self.terms += [:prevent_download]
  end
end

