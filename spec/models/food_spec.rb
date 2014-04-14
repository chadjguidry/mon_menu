# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  category    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  ingredients :text
#  prep        :text
#  prep_time   :integer
#

require 'spec_helper'

describe Food do
  pending "add some examples to (or delete) #{__FILE__}"
end
