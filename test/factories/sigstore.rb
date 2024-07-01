FactoryBot.define do
  factory :sigstore_x509_certificate, class: "Sigstore::Common::V1::X509Certificate" do
    transient do
      x509_certificate factory: %i[x509_certificate key_usage]
    end
    initialize_with do
      cert = new
      cert.raw_bytes = x509_certificate.to_der
      cert
    end
    to_create { |instance| instance }
  end
  factory :sigstore_verification_material, class: "Sigstore::Bundle::V1::VerificationMaterial" do
    certificate factory: %i[sigstore_x509_certificate]
    to_create { |instance| instance }
  end

  factory :sigstore_bundle, class: "Sigstore::Bundle::V1::Bundle" do
    media_type { Sigstore::BundleType::BUNDLE_0_3.media_type }
    verification_material factory: %i[sigstore_verification_material]
    to_create { |instance| instance }
  end
end
