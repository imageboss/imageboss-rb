require 'spec_helper'

describe ImageBoss::Client do
  let(:service) { 'https://img.imageboss.me' }
  let(:source) { 'myassets' }
  let(:client_args) {{
    source: source
  }}

  let(:operation_args) { [:cover, width: 100, height: 100] }

  subject { described_class.new(**client_args) }

  context 'initialize' do
    it { expect(subject.instance_variable_get(:@options)).to eq({
        source: client_args[:source],
        enabled: true,
        secret: false
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
      it { expect(image_url).to eq "#{service}/#{source}/cover/100x100/assets/img01.jpg" }

      context 'with options' do
        let(:operation_args) { [:cover, width: 100, height: 100, options: { grayscale: true, blur: 2.0 } ] }
        it { expect(image_url).to eq "#{service}/#{source}/cover/100x100/grayscale:true,blur:2.0/assets/img01.jpg" }
      end

      context 'with options #2' do
        let(:operation_args) { [:cover, width: 100, height: 100, options: { animation: true } ] }
        it { expect(image_url).to eq "#{service}/#{source}/cover/100x100/animation:true/assets/img01.jpg" }
      end

      context 'mode' do
        let(:operation_args) { [:cover, mode: :entropy, width: 100, height: 100 ] }
        it { expect(image_url).to eq "#{service}/#{source}/cover:entropy/100x100/assets/img01.jpg" }

        context 'with options' do
          let(:operation_args) { [:cover, mode: :entropy, width: 100, height: 100, options: { grayscale: true, blur: 2.0 } ] }
          it { expect(image_url).to eq "#{service}/#{source}/cover:entropy/100x100/grayscale:true,blur:2.0/assets/img01.jpg" }
        end
      end

    end

    context 'width' do
      let(:operation_args) { [:width, width: 100 ] }
      it { expect(image_url).to eq "#{service}/#{source}/width/100/assets/img01.jpg" }
    end

    context 'height' do
      let(:operation_args) { [:height, height: 200 ] }
      it { expect(image_url).to eq "#{service}/#{source}/height/200/assets/img01.jpg" }
    end

    context 'cdn' do
      let(:operation_args) { [:cdn] }
      it { expect(image_url).to eq "#{service}/#{source}/cdn/assets/img01.jpg" }
    end

    context 'disabled  client' do
      let(:client_args) {{
        source: source,
        enabled: false
      }}

      let(:operation_args) { [:height, height: 200 ] }
      it { expect(image_url).to eq '/assets/img01.jpg' }
    end
  end

  context 'secure token' do
    let(:client_args) {{
      source: source,
      secret: 'abc'
    }}

    let(:operation_args) { [:cover, width: 100, height: 100] }

    let(:path) {
      subject
        .path('/assets/img01.jpg?existing=oh')
    }

    let(:image_url) { path.operation(*operation_args) }

    subject { described_class.new(**client_args) }

    context 'initialize' do
      context 'width' do
        let(:operation_args) { [:width, width: 100 ] }
        it { expect(image_url).to eq "#{service}/#{source}/width/100/assets/img01.jpg?existing=oh&bossToken=ff74a46c7228ee4262c39b8d501c488293c5be9d433bb9ca957f32c9c3d844ab" }
      end
    end
  end
end
