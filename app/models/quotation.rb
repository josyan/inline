class Quotation < ActiveRecord::Base
  has_many :quotation_lines, :dependent => :destroy
  has_many :door_lines, :dependent => :destroy
  has_many :options_quotations, :dependent => :destroy
  belongs_to :user
  belongs_to :company

  validates_presence_of :project_name
  validates_numericality_of :markup, :allow_nil => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 30
  validates_numericality_of :deposit, :allow_nil => true, :greater_than_or_equal_to => 0

  after_initialize :set_tax_rates

  def set_tax_rates
    if new_record? && !changed?
      self.taxes ||= 5.0
      self.taxes_pst ||= 9.5
    end
  end

  def use_billing_address?
    if (customer_address.nil? || delivery_address.nil?)
     return false
    end

   return customer_address == delivery_address
  end

  def calculate_taxes(total)
   total * self.taxes / 100.0
  end

  def calculate_pst(total)
    if !self.taxes_pst.blank?
      total * self.taxes_pst / 100.0
    else
     0.0
    end
  end

  # given a source quotation, copy to new with derivative slug
  def self.copy(orig_quotation)
    quotation = orig_quotation.clone(:include => [:options_quotations, {:quotation_lines => [:quotation_lines_openings, :options_quotation_lines, :section_heights, :section_widths] }, {:door_lines => [:door_line_sections, :door_line_options]}])
    quotation.slug = quotation.generate_new_slug(orig_quotation.slug)
    quotation
  end

  def regenerate_previews
    quotation_lines.each do |line|
      line.create_image
    end
    door_lines.each do |line|
      line.create_image
    end
  end

  def generate_new_slug(slug)
    last = 1
    base_slug = slug.slice(/.*-/) || slug + "-"
    existing_slugs = Quotation.connection.select_all("select slug from quotations where slug like '#{base_slug}%'")
    existing_slugs = existing_slugs.collect {|s| s["slug"]}
    last = existing_slugs.collect{|s| s[((s.rindex('-')||-1)+1)..-1].to_i}.max() + 1  unless existing_slugs.empty?

    return base_slug + last.to_s
  end
end
