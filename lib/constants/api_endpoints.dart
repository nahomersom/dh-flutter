class EndPoints {
  static const baseUrl = 'http://188.245.101.26:8000';
  // static const baseUrl = 'http://172.23.48.1:8000';
  static const String socketUrl = "ws://188.245.101.26:8000";

  static const String refresh = "$baseUrl/auth/refresh";
  static const String sendCode = "$baseUrl/auth/send-otp";
  static const String checkUser = "$baseUrl/auth/user/find";
  static const String getAllUsers = "$baseUrl/auth/users";
  static const String searchUsers = "$baseUrl/auth/search";
  static const String downloadFile = "$baseUrl/download-file";
  static const String verifyCode = "$baseUrl/auth/verify-otp";
  static const String completeProfile = "$baseUrl/auth/complete-profile";
  static const String getMe = "$baseUrl/auth/get/me";
  static const String createOrganization = "$baseUrl/organization";
  static const String searchOrganization = "$baseUrl/organization/search";
  static const String sendInvitation = "$baseUrl/organization";
  static const String orgInvite = "$baseUrl/org-invite";
  static const String getMyOrgInvite = "$baseUrl/org-invite/my/invites";
  static const String getMyOrganizations = "$baseUrl/organization/my";
  static const String changeRequestStatus = "$baseUrl/organization";
  static const String getIndustries = "$baseUrl/industries";
  static const String getRegions = "$baseUrl/regions";
  static const String orgMember = "$baseUrl/org-member";
  static const String orgGroup = "$baseUrl/org-group";
  static const String getMyOrgGroups = "$baseUrl/org-group/my-groups";
  static const String getMyPersonalGroups =
      "$baseUrl/org-group/my-personal-groups";
  static const String orgGroupMembers = "$baseUrl/org-group-members";
  static const String tasks = "$baseUrl/tasks";
  static const String assignTask = "$baseUrl/tasks/assign";
  static const String myTasks = "$baseUrl/tasks/my/assigned";
  static const String updateTask = "$baseUrl/tasks/update";
  static const String tasksGroup = "$baseUrl/tasks/group";
  static const String getTasksICreated = "$baseUrl/tasks/my/created";
  static const String approveProfile = "$baseUrl/admin/approve-profile";
  static const String getMyNotification =
      "$baseUrl/notifications/my-notifications";
  static const String notifications = "$baseUrl/notifications";
  static const String sendPrivateMessage = "$baseUrl/chat/private-message";
  static const String getMyChatLists = "$baseUrl/chat/my-private-chat-users";
  static const String getMyPrivateChatHistory = "$baseUrl/chat/private";
  static const String changeChatStatus = "/chat/private-message";

  static const String registerEmployee = "$baseUrl/employees/register-employee";
  static const String getEmployees = "$baseUrl/employees/get-employees";
  static const String deleteEmployee = "$baseUrl/employees/delete-employee";
  static const String deleteEmployer = "$baseUrl/employers/delete-employer";
  static const String getFilteredEmployees =
      "$baseUrl/employees/get-filtered-employees";
  static const String getHiredEmployees =
      "$baseUrl/employees/get-hired-employees";
  static const String sendLeaveRequest = "$baseUrl/employees/request-leave";
  static const String leaveJob = "$baseUrl/employees/leave-job";
  static const String updateLeaveRequest =
      "$baseUrl/employees/accept-or-reject-leave-request";
  static const String getEmployee = "$baseUrl/employees/get-employee";
  static const String getEmployeesByService =
      "$baseUrl/employees/get-employees-by-services";
  static const String getEmployeesByServiceWithPagination =
      "$baseUrl/employees/get-employees-by-services-with-pagination";
  static const String updateEmployee = "$baseUrl/employees/update-profile";
  static const String updateEmployeeProfile =
      "$baseUrl/employees/update-my-profile";
  static const String updateEmployerProfile =
      "$baseUrl/employers/update-my-profile";
  static const String getEmployer = "$baseUrl/employers/get-employer";
  static const String updateEmployer = "$baseUrl/employers/update-employer";
  static const String registerEmployer = "$baseUrl/employers/register-employer";
  static const String acceptHireRequest =
      "$baseUrl/employees/accept-hire-request";
  static const String getServices = "$baseUrl/services/get-services";
  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String getFavoriteEmployee =
      "$baseUrl/favorite-employees/get-favorite-employees";
  static const String addFavoriteEmployee =
      "$baseUrl/favorite-employees/create-favorite-employee";
  static const String getJobs = "$baseUrl/jobs/get-jobs";
  static const String changeNewApplicationStatus =
      "$baseUrl/jobs/change-new-application-status";

  static const String getJobsForMe = "$baseUrl/jobs/get-jobs-for-me";
  static const String getEmployeesForMe =
      "$baseUrl/employees/get-employees-for-me";
  static const String addFavoriteJob = "$baseUrl/favorite-jobs/create-favorite";
  static const String removeFavoriteJob =
      "$baseUrl/favorite-jobs/delete-favorite";
  static const String getFavoriteJob = "$baseUrl/favorite-jobs/get-favorites";
  static const String getJobById = "$baseUrl/jobs/get-job";
  static const String updateJob = "$baseUrl/jobs/update-job";
  static const String closeOrOpenJob = "$baseUrl/jobs/open-or-close-job";
  static const String getRequests = "$baseUrl/requests/get-requests";
  static const String createRequest = "$baseUrl/requests/create-request";
  static const String updateRequestStatus = "$baseUrl/requests/change-status";
  static const String getCandidatesWithJobId =
      "$baseUrl/jobs/get-candidates-with-job-id";
  static const String createJob = "$baseUrl/jobs/create-job";
  static const String addCandidate = "$baseUrl/jobs/add-candidate";
  static const String removeCandidate = "$baseUrl/jobs/remove-candidate";
  static const String hireEmployee = "$baseUrl/employees/hire-employee";
  static const String getAdverts = "$baseUrl/adverts/get-adverts";
  static const String resetPassword = "$baseUrl/auth/update-password";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String checkPhoneNumber = "$baseUrl/accounts/check-account";
  static const String getNotification =
      "$baseUrl/notifications/get-notifications";
  static const String getPaymentPlan =
      "$baseUrl/payment-plans/get-payment-plans";
  static const String payWithChapa =
      "$baseUrl/payments/pay-with-chapa-for-employee";
  static const String payWithChapaEmployer = "$baseUrl/payments/pay-with-chapa";
  static const String checkPayment = "$baseUrl/payments/check-payment";
  static const String getConfigurations =
      "$baseUrl/configurations/get-configurations";
  static const String createFeedback = "$baseUrl/feedbacks/create-feedback";
  static const String createReview = "$baseUrl/reviews/create-review";
  static const String getReviews = "$baseUrl/reviews/get-reviews";
  static const String getFilteredReviews =
      "$baseUrl/reviews/get-filtered-reviews";
  static const String getExams = "$baseUrl/exams/get-exams";
  static const String answerExams = "$baseUrl/exams/create-result";
  static const String changeVisibility = "$baseUrl/employees/change-visibility";
}
