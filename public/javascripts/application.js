// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function updateShippingAddress() {
    var checked = $('use_billing_address').checked;
    var deliveryAddress = $('delivery_address');
    if (checked) {
        deliveryAddress.value = $('customer_address').value;
    }
}
