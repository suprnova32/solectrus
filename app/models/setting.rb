# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  value      :text
#  var        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
class Setting < RailsSettings::Base
  cache_prefix { 'v1' }

  field :setup_id, type: :integer
  field :setup_token, type: :string

  def self.seed!
    Setting.setup_id ||= Price.first&.created_at&.to_i || Time.current.to_i
    Setting.setup_token ||= SecureRandom.alphanumeric(16)
  end
end