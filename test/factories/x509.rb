FactoryBot.define do
  factory :x509_certificate, class: "OpenSSL::X509::Certificate" do
    subject { OpenSSL::X509::Name.parse("/DC=org/DC=example/CN=Test") }
    issuer { subject }
    version { 2 }
    serial { 1 }
    not_before { 1.day.ago }
    not_after { 1.year.from_now }
    public_key { OpenSSL::PKey::EC.generate("prime256v1") }
    transient do
      extension_factory { OpenSSL::X509::ExtensionFactory.new }
    end

    trait :key_usage do
      after(:build) do |cert, ctx|
        cert.add_extension(ctx.extension_factory.create_ext("keyUsage", "digitalSignature", true))
        cert.add_extension(ctx.extension_factory.create_ext("2.5.29.37", "critical,DER:30:0A:06:08:2B:06:01:05:05:07:03:03"))
      end
    end

    after(:build) do |cert, ctx|
      cert.sign(ctx.public_key, OpenSSL::Digest.new("SHA256"))
    end

    to_create { |instance| instance }
  end
end
