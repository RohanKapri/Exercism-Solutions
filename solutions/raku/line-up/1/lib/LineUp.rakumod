sub deli-order ( :$customer, :$ticket ) is export {

    sprintf '%s, you are the %s%s customer we serve today. Thank you!',
        $customer,
        $ticket,
     .{ $ticket .comb .tail( 2 ) .join .Int }
  || .{ $ticket .comb .tail                 }
  || 'th'
    with <11 th 12 th 13 th 1 st 2 nd 3 rd> .pairup .Hash

}