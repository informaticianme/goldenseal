# Generated via
#  `rails generate curation_concerns:work Image`
module CurationConcerns
  class ImageActor < CurationConcerns::BaseActor
    include ::CurationConcerns::WorkActorBehavior
    include CommonActorBehavior
  end
end
