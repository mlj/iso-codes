require 'iso_codes'
require 'test/unit'

class ISO6393CodesTestCase < Test::Unit::TestCase
  def test_find_language
    l = ISOCodes::find_language("eng")
    assert_not_nil l
    assert_equal   'eng', l.identifier
    assert_equal   'eng', l.alpha3_terminology
    assert_equal   'eng', l.alpha3_bibliographic
    assert_equal   'en', l.alpha2
    assert_equal   'English', l.reference_name
  end

  def test_find_language_macrolanguage
    l = ISOCodes::find_language("ara")
    assert_not_nil l
    assert_kind_of ISOCodes::Macrolanguage, l
    assert         l.individual_languages.any? { |c| c.identifier == 'arq' }
  end

  def test_doc_exx
    language = ISOCodes.find_language('lav')
    assert_equal 'Latvian', language.reference_name
    assert_equal ISOCodes::Macrolanguage, language.class
    assert_equal 'lav', language.alpha3_bibliographic
    assert_equal 'lv', language.alpha2

    assert_equal ["ltg", "lvs"], language.individual_languages.map { |l| l.identifier }

    language = ISOCodes.find_language('ltg')
    assert_equal ISOCodes::IndividualLanguage, language.class
    assert_equal "lav", language.macrolanguage.identifier
  end
end
