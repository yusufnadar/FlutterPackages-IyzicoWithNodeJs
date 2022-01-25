const express = require('express');
var Iyzipay = require('iyzipay');
const app = express();

app.listen(3000,()=>{
    console.log('porta bağlandı');
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.post('/',(req,res)=>{
   const {basketItems,cardNumber,cardHolderName,cvvCode,month,year} = req.body;
    basketItems.forEach(element => {
        element.itemType = Iyzipay.BASKET_ITEM_TYPE.PHYSICAL;
    });
    var request = {
        locale: Iyzipay.LOCALE.TR,
        conversationId: '123456789',
        price: '300',
        paidPrice: '300',
        currency: Iyzipay.CURRENCY.TRY,
        installment: '1',
        basketId: 'B67832',
        paymentChannel: Iyzipay.PAYMENT_CHANNEL.WEB,
        paymentGroup: Iyzipay.PAYMENT_GROUP.PRODUCT,
        paymentCard: {
            cardHolderName: cardHolderName,
            cardNumber: cardNumber,
            expireMonth: month,
            expireYear: year,
            cvc: cvvCode,
            registerCard: '0'
        },
        buyer: {
            id: 'BY789',
            name: 'John',
            surname: 'Doe',
            gsmNumber: '+905350000000',
            email: 'email@email.com',
            identityNumber: '74300864791',
            lastLoginDate: '2015-10-05 12:43:35',
            registrationDate: '2013-04-21 15:12:09',
            registrationAddress: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
            ip: '85.34.78.112',
            city: 'Istanbul',
            country: 'Turkey',
            zipCode: '34732'
        },
        shippingAddress: {
            contactName: 'Jane Doe',
            city: 'Istanbul',
            country: 'Turkey',
            address: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
            zipCode: '34742'
        },
        billingAddress: {
            contactName: 'Jane Doe',
            city: 'Istanbul',
            country: 'Turkey',
            address: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
            zipCode: '34742'
        },
        basketItems: basketItems
    };

    var iyzipay = new Iyzipay({
        apiKey: "sandbox-oSAnuvigT3ZIk0c4ErPhDyXDNgITAfRJ",
        secretKey: "sandbox-dirOe1vcUJ8hRAl7Umzi1PdzfZwUrpBX",
        uri: 'https://sandbox-api.iyzipay.com'
    });
    
    iyzipay.payment.create(request, function (err, result) {
        console.log(err, result);
        res.send('başarılı');
    });
});