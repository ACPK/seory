require 'spec_helper'
require 'seory/runtime'

describe Seory::Runtime do
  let(:seory) do
    Seory::Runtime.new(definition, controller)
  end

  let(:controller) { double('controller') }
  let(:definition) { double('definition') }

  context 'static content' do
    before do
      allow(definition).to receive(:definition_for).with(:title) { 'A title' }
    end

    describe '#title' do
      specify { expect(seory.title).to eq 'A title' }
    end
  end

  context 'controller based dynamic content' do
    before do
      allow(controller).to receive(:action_name) { 'edit' }
      allow(definition).to receive(:definition_for).with(:title) { -> { "#{action_name.upcase} | My Site" } }
    end

    describe '#titie' do
      specify { expect(seory.title).to eq 'EDIT | My Site' }
    end
  end
end
