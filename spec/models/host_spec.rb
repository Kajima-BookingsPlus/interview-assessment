# == Schema Information
#
# Table name: hosts
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  mobile     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Host, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
