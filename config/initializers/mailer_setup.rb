ActionMailer::Base.delivery_method = :test
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true

ActionMailer::Base.smtp_settings = {
  address: 'smtp.childrenshc.org',
  domain: 'childrensmn.org',
  openssl_verify_mode: 'none'
}
