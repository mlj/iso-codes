#--
# Copyright (c) 2016 Marius L. Jøhndal
#
# See LICENSE in the top-level source directory for licensing terms.
#++
require 'spec_helper'

describe ISOCodes do
  it 'finds a language by code' do
    l = ISOCodes::find_language('eng')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('eng')

    l = ISOCodes::find_language('olt')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('olt')

    l = ISOCodes::find_language('ara')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('ara')

    l = ISOCodes::find_language('lav')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('lav')

    l = ISOCodes::find_language('ltg')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('ltg')
  end

  it 'returns languages with alpha3 codes' do
    l = ISOCodes::find_language('eng')

    expect(l.alpha3_terminology).to eql('eng')
    expect(l.alpha3_bibliographic).to eql('eng')

    l = ISOCodes::find_language('olt')

    expect(l.alpha3_terminology).to be nil
    expect(l.alpha3_bibliographic).to be nil

    l = ISOCodes::find_language('ara')

    expect(l.alpha3_terminology).to eql('ara')
    expect(l.alpha3_bibliographic).to eql('ara')

    l = ISOCodes::find_language('lav')

    expect(l.alpha3_terminology).to eql('lav')
    expect(l.alpha3_bibliographic).to eql('lav')

    l = ISOCodes::find_language('ltg')

    expect(l.alpha3_terminology).to be nil
    expect(l.alpha3_bibliographic).to be nil
  end

  it 'returns languages with alpha2 codes' do
    l = ISOCodes::find_language('eng')

    expect(l.alpha2).to eql('en')

    l = ISOCodes::find_language('olt')

    expect(l.alpha2).to be nil

    l = ISOCodes::find_language('ara')

    expect(l.alpha2).to eql('ar')

    l = ISOCodes::find_language('lav')

    expect(l.alpha2).to eql('lv')

    l = ISOCodes::find_language('ltg')

    expect(l.alpha2).to be nil
  end

  it 'returns languages with reference names' do
    l = ISOCodes::find_language('eng')

    expect(l.reference_name).to eql('English')

    l = ISOCodes::find_language('olt')

    expect(l.reference_name).to eql('Old Lithuanian')

    l = ISOCodes::find_language('ara')

    expect(l.reference_name).to eql('Arabic')

    l = ISOCodes::find_language('lav')

    expect(l.reference_name).to eql('Latvian')

    l = ISOCodes::find_language('ltg')

    expect(l.reference_name).to eql('Latgalian')
  end

  it 'returns macrolanguages' do
    l = ISOCodes::find_language("ara")

    expect(l).to_not be_nil
    expect(l.identifier).to eql('ara')
    expect(l).to be_a(ISOCodes::Macrolanguage)
    expect(l.individual_languages.map(&:identifier)).to eq %w(aao abh abv acm acq acw acx acy adf aeb aec afb ajp apc apd arb arq ars ary arz auz avl ayh ayl ayn ayp bbz pga shu ssh)

    l = ISOCodes.find_language('lav')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('lav')
    expect(l).to be_a(ISOCodes::Macrolanguage)
    expect(l.individual_languages.map(&:identifier)).to eq %w(ltg lvs)
  end

  it 'identifies the macrolanguage of an individual language' do
    l = ISOCodes.find_language('ltg')

    expect(l).to_not be_nil
    expect(l.identifier).to eql('ltg')
    expect(l).to be_a(ISOCodes::IndividualLanguage)
    expect(l).to_not be_a(ISOCodes::Macrolanguage)
    expect(l.macrolanguage.identifier).to eql('lav')
  end
end
