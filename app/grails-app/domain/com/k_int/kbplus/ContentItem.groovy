package com.k_int.kbplus

class ContentItem {

  String key
  String locale
  String content

  static mapping = {
         id column:'ci_id'
        key column:'ci_key'
     locale column:'ci_locale'
    content column:'ci_content', type:'text'
  }

  static constraints = {
        key(nullable:false, blank:false)
     locale(nullable:false, blank:true)
    content(nullable:false, blank:false)
  }

  static def lookupOrCreate(key,locale,content) {
    def result = ContentItem.findByKeyAndLocale(key,locale)
    if ( result == null ) {
      result = new ContentItem(key:key, locale:locale, content:content).save();
    }
    result
  }
}
