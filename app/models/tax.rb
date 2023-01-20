class Tax < ApplicationRecord
  belongs_to :user
  belongs_to :salary
  validates :arl, :salud, :pension, :fsp, :cesantias, :ccf, presence: true
  
  attr_accessor :total
  
  before_save :calculate_taxes
  
  def calculate_taxes
    self.arl = calculate_arl(clase_riesgo)
    self.salud = calculate_salud
    self.pension = calculate_pension
    self.fsp = calculate_fsp(salario_minimo)
    self.cesantias = calculate_cesantias
    self.ccf = calculate_ccf(ibc_percentage)
    self.total = arl + salud + pension + fsp + cesantias + ccf
  end
  
  def calculate_arl(clase_riesgo)
    tarifas_arl = {
        1: 0.00522,
        2: 0.01044,
        3: 0.02436,
        4: 0.04350,
        5: 0.06960
    }
    self.ibc * tarifas_arl.fetch(clase_riesgo, 0)
  end
  
  def calculate_salud
    self.ibc * 0.126
  end
  
  def calculate_pension
    self.ibc * 0.16
  end
  
  def calculate_fsp(salario_minimo)
    fsp_ranges = [(0, 4, 0), (4, 16, 0.01), (16, 17, 0.012), (17, 18, 0.014), (18, 19, 0.016), (19, 20, 0.018), (20, float('inf'), 0.02)]
    tarifa_fsp = 0
    fsp_ranges.each do |r|
      if self.ibc >= r[0] * salario_minimo and self.ibc < r[1] * salario_minimo
        tarifa_fsp = self.ibc * r[2]
        break
      end
    end
    tarifa_fsp
  end
  
  def calculate_cesantias
    (self.ibc/1.2)*12
  end
  def calculate_ccf(ibc_percentage)
    self.ibc * ibc_percentage
  end
  
  def ibc
    self.salary.amount * 0.4
  end
end