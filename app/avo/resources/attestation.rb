class Avo::Resources::Attestation < Avo::BaseResource
  self.title = :id
  self.includes = [:version]

  def fields
    field :id, as: :id

    field :version, as: :belongs_to
    field :media_type, as: :text
    field :body, as: :json_viewer
  end
end
