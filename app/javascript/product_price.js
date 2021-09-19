function product_price() {
  const productPrice = document.getElementById("item-price");
    productPrice.addEventListener('change', () => {
      const price = productPrice.value;
      const addTaxPrice = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      const taxPrice = price * 0.1;
      const saleProfit = price - taxPrice;
      
      addTaxPrice.innerHTML = taxPrice;
      profit.innerHTML = saleProfit; 
  });
}
window.addEventListener("load", product_price);