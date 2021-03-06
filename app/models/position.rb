class Position < ApplicationRecord
  has_many :employees, dependent: :restrict_with_error
  has_paper_trail

  validates :nombre_cargo, presence: { message: "No puede estar Vacio" }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten Letras" },  uniqueness: { message: "Ya existe" }
end
