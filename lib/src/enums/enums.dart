enum AttendanceEventType { attendanceIN, attendanceOUT }

enum Purpose { personal, official, end }

enum LocationType { office, known, others }

enum LocationDelivary { known, map, warehouse }

// enum LogisticSetting { defult, mandatory }

enum PartyType { person, agency }

enum LoadFrom { nmsBudget, projectBudget }

//logistics setting

enum Enforcement { defaultControls, mandatoryControls }

enum FirstApproverAuthority {
  reportingManager,
  unitManager,
  agencyManager,
  agencyController,
  geographymatrix
}

enum SecondApproverAuthority {
  locationmanager,
  unitManager,
  agencyManager,
  geographyMatrix,
  agencyController
}

enum ThirdApproverAuthority {
  locationmanager,
  unitManager,
  agencyManager,
  geographyMatrix,
  agencyController,
}

//project management setting
enum EnforcementProject { defaultControls, mandatoryControls }

enum FirstProjectApproverAuthority {
  reportingManager,
  agencyManager,
  agencyController,
  unitManager,
}

enum SecondProjectApproverAuthority {
  unitManager,
  agencyManager,
  agencyController
}

enum ThirdProjectApproverAuthority {
  locationmanager,
  unitManager,
  agencyManager,
  geographyMatrix,
  agencyController,
}

//Test approval authority
enum FirstTestApprovalAuthority {
  projectManager,
  agencymanager,
  geographymatrix,
  agencycontroller,
}

enum SecondTestApprovalAuthority {
  projectManager,
  agencymanager,
  geographymatrix,
  agencycontroller,
}

enum ThirdTestApprovalAuthority {
  projectManager,
  agencymanager,
  geographymatrix,
  agencycontroller,
}

//Project Site Relocation Approval Authority

enum FirstProjectSiteRelocationApprovalAuthority {
  projectManager,
  agencymanager,
  geographymatrix,
  agencycontroller,
}

enum SecondProjectSiteRelocationApprovalAuthority {
  projectManager,
  agencymanager,
  geographymatrix,
  agencycontroller,
}

enum ThirdProjectSiteRelocationApprovalAuthority {
  projectManager,
  agencymanager,
  geographymatrix,
  agencycontroller,
}

enum ViewType { geographies, materials }
