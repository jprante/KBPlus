package com.k_int.kbplus

import com.k_int.kbplus.auth.*
import grails.plugins.springsecurity.Secured

class MyInstitutionsController {

  def springSecurityService


  @Secured(['ROLE_USER', 'IS_AUTHENTICATED_FULLY'])
  def index() { 
    // Work out what orgs this user has admin level access to
    def result = [:]
    result.user = User.get(springSecurityService.principal.id)

    def adminRole = Role.findByAuthority('ROLE_ADMIN')

    
    if ( result.user.authorities.contains(adminRole) ) {
      log.debug("User is in admin role");
      result.orgs = Org.findAllBySector("Higher Education");
    }
    else {
      result.orgs = Org.findAllBySector("Higher Education");
    }

    result
  }
}