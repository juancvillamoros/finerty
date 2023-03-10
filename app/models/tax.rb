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
  
  def calcular_arl(clase_riesgo)
    tarifas_arl = {
      1 => 0.00522,
      2 => 0.01044,
      3 => 0.02436,
      4 => 0.04350,
      5 => 0.06960
    }
    return calcular_ibc() * tarifas_arl.fetch(clase_riesgo, 0)
  end
  
  def calculate_salud
    ibc * 0.126
  end
  
  def calculate_pension
    ibc * 0.16
  end
  
  def calcular_fsp
    fsp_ranges = [[0, 4, 0], [4, 16, 0.01], [16, 17, 0.012], [17, 18, 0.014], [18, 19, 0.016], [19, 20, 0.018], [20, Float::INFINITY, 0.02]]
    ibc = calcular_ibc()
    tarifa_fsp = 0
    fsp_ranges.each do |r|
      if ibc >= r[0] * SALARIO_MINIMO and ibc < r[1] * SALARIO_MINIMO
        tarifa_fsp = ibc * r[2]
        break
      end
    end
    return tarifa_fsp
  end

  def calculate_cesantias
    (ibc/1.2)*12
  end
  
  def ibc
    salary.amount * 0.4
  end
end