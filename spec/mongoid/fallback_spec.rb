# encoding: utf-8
require 'spec_helper'
require "i18n/backend/fallbacks.rb"

module Mongoid
  describe 'I18n::Fallback with Mongoid::Slug' do
    
    
    let(:book) do
      Book.create(title: 'A Thousand Plateaus')
    end

    context 'slug can be localized' do
      before(:each) do
        @old_locale = I18n.locale
      end

      after(:each) do
        I18n.locale = @old_locale
      end

      it 'exact same title multiple langauges when setting one at a time' do
        page = PageSlugLocalized.create!(title:"Title on English") 
        expect(page['_slugs']).to eq('en' => ['title-on-english'])      
  
        I18n.with_locale("nl") do
          page.update_attributes(title:"Title on English")
        end
        
        expect(page['_slugs']).to eq('en' => ['title-on-english'], 'nl' => ['title-on-english'])
      end
      
    end
  end
end
