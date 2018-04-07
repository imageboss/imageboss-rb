require 'spec_helper'

describe ImageBoss::Client do
  let(:service) { 'https://service.imageboss.me' }
  let(:client_args) {{
    domain: 'https://myassets.com'
  }}

  let(:operation_args) { [:cover, width: 100, height: 100] }

  subject { described_class.new(**client_args) }

  context 'initialize' do
    it { expect(subject.instance_variable_get(:@options)).to eq({
        domain: client_args[:domain],
        enabled: true
      })
    }
  end

  context 'path' do
    let(:path) {
      subject
        .path('/assets/img01.jpg')
    }

    let(:image_url) { path.operation(*operation_args) }

    context 'cover' do
      it { expect(image_url).to eq "#{service}/cover/100x100/https://myassets.com/assets/img01.jpg" }

      context 'with options' do
        let(:operation_args) { [:cover, width: 100, height: 100, options: { grayscale: true, blur: 2.0 } ] }
        it { expect(image_url).to eq "#{service}/cover/100x100/grayscale:true,blur:2.0/https://myassets.com/assets/img01.jpg" }
      end

      context 'mode' do
        let(:operation_args) { [:cover, mode: :entropy, width: 100, height: 100 ] }
        it { expect(image_url).to eq "#{service}/cover:entropy/100x100/https://myassets.com/assets/img01.jpg" }

        context 'with options' do
          let(:operation_args) { [:cover, mode: :entropy, width: 100, height: 100, options: { grayscale: true, blur: 2.0 } ] }
          it { expect(image_url).to eq "#{service}/cover:entropy/100x100/grayscale:true,blur:2.0/https://myassets.com/assets/img01.jpg" }
        end
      end

    end

    context 'width' do
      let(:operation_args) { [:width, width: 100 ] }
      it { expect(image_url).to eq "#{service}/width/100/https://myassets.com/assets/img01.jpg" }
    end

    context 'height' do
      let(:operation_args) { [:height, height: 200 ] }
      it { expect(image_url).to eq "#{service}/height/200/https://myassets.com/assets/img01.jpg" }
    end

    context 'cdn' do
      let(:operation_args) { [:cdn] }
      it { expect(image_url).to eq "#{service}/cdn/https://myassets.com/assets/img01.jpg" }
    end

    fcontext 'disabled  client' do
      let(:client_args) {{
        domain: 'https://myassets.com',
        enabled: false
      }}

      let(:operation_args) { [:height, height: 200 ] }
      it { expect(image_url).to eq '/assets/img01.jpg' }
    end
  end
end
