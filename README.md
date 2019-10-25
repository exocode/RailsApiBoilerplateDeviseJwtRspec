# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* JSON rspec

## Airbone matchers 
https://github.com/brooklynDev/airborne

- `expect_json` - Tests the values of the JSON property values returned
- `expect_json_types` - Tests the types of the JSON property values returned
- `expect_json_keys` - Tests the existence of the specified keys in the JSON object
- `expect_json_sizes` - Tests the sizes of the JSON property values returned, also test if the values are arrays
- `expect_status` - Tests the HTTP status code returned
- `expect_header` - Tests for a specified header in the response
- `expect_header_contains` - Partial match test on a specified header

## Shoulda Matchers
https://github.com/thoughtbot/shoulda-matchers

### ActiveModel matchers
- `allow_value` tests that an attribute is valid or invalid if set to one or more values. (Aliased as #allow_values.)
- `have_secure_password` tests usage of has_secure_password.
- `validate_absence_of` tests usage of validates_absence_of.
- `validate_acceptance_of` tests usage of validates_acceptance_of.
- `validate_confirmation_of` tests usage of validates_confirmation_of.
- `validate_exclusion_of` tests usage of validates_exclusion_of.
- `validate_inclusion_of` tests usage of validates_inclusion_of.
- `validate_length_of` tests usage of validates_length_of.
- `validate_numericality_of` tests usage of validates_numericality_of.
- `validate_presence_of` tests usage of validates_presence_of.

### ActiveRecord matchers
- `accept_nested_attributes_for` tests usage of the accepts_nested_attributes_for macro.
- `belong_to` tests your belongs_to associations.
- `define_enum_for` tests usage of the enum macro.
- `have_and_belong_to_many` tests your has_and_belongs_to_many associations.
- `have_db_column` tests that the table that backs your model has a specific column.
- `have_db_index` tests that the table that backs your model has an index on a specific column.
- `have_many` tests your has_many associations.
- `have_one` tests your has_one associations.
- `have_readonly_attribute` tests usage of the attr_readonly macro.
- `serialize` tests usage of the serialize macro.
- `validate_uniqueness_of` tests usage of validates_uniqueness_of.

### ActionController matchers
- `filter_param` tests parameter filtering configuration.
- `permit` tests that an action places a restriction on the params hash.
- `redirect_to` tests that an action redirects to a certain location.
- `render_template` tests that an action renders a template.
- `render_with_layout` tests that an action is rendered with a certain layout.
- `rescue_from` tests usage of the rescue_from macro.
- `respond_with` tests that an action responds with a certain status code.
- `route` tests your routes.
- `set_session` makes assertions on the session hash.
- `set_flash` makes assertions on the flash hash.
- `use_after_action` tests that an after_action callback is defined in your controller.
- `use_around_action` tests that an around_action callback is defined in your controller.
- `use_before_action` tests that a before_action callback is defined in your controller.

## GraphqlMatchers
https://github.com/khamusa/rspec-graphql_matchers

- `have_a_field(field_name).of_type(valid_type)`
- `implement(interface_name, ...)`
- `have_a_return_field(field_name).returning(valid_type)`
- `have_an_input_field(field_name).of_type(valid_type)`
- `be_of_type(valid_type)`
- `accept_argument(argument_name).of_type(valid_type)`
