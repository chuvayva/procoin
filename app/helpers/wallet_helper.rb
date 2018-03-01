module WalletHelper
  def num_with_spaces(num)
    num.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")
  end
end
