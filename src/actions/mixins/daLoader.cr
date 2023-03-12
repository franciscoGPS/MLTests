require "crysda"

module DataLoader
  def load(filename) : Crysda::DataFrame
    Crysda.read_csv("#{ENV["DS_DIR"]}/#{filename}")
  end
end
