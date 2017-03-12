class AuthorDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(
      Author.name
      Author.age
      Author.gender
      Author.email
      Author.city
      Author.phone
      Author.employer
    )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= sortable_columns
  end

  private

  def data
    records.map do |record|
      [
          record.name,
          record.age,
          record.gender,
          record.email,
          record.city,
          record.phone,
          record.employer
      ]
    end
  end

  def get_raw_records
    Author.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end

