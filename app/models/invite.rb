class Invite < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :code
  validates_inclusion_of :used, :in => [true, false]
  before_validation do
    self.used ||= false
    until self.code.present? && Invite.find_by_code(self.code) == nil
      @@generator ||= UUID.new
      self.code = (Digest::SHA1.hexdigest @@generator.generate)[0..8]
    end
  end
end
