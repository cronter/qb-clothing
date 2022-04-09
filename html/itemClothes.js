let selectedClothes = {
    ['t-shirt']: { selected: false, value: 0 },
    ['torso2']: { selected: false, value: 0 },
    ['vest']: { selected: false, value: 0 },
    ['accessory']: { selected: false, value: 0 },
    ['bag']: { selected: false, value: 0 },
    ['pants']: { selected: false, value: 0 },
    ['shoes']: { selected: false, value: 0 },
    ['hat']: { selected: false, value: 0 },
    ['glass']: { selected: false, value: 0 },
    ['ear']: { selected: false, value: 0 },
    ['watch']: { selected: false, value: 0 },
    ['bracelet']: { selected: false, value: 0 },
    ['mask']: { selected: false, value: 0 },


}

let selectedClothesTextures = {
    ['t-shirt']: { value: 0 },
    ['torso2']: {  value: 0 },
    ['vest']: { value: 0 },
    ['accessory']: { value: 0 },
    ['bag']: {  value: 0 },
    ['pants']: {  value: 0 },
    ['shoes']: { value: 0 },
    ['hat']: { value: 0 },
    ['glass']: { value: 0 },
    ['ear']: { value: 0 },
    ['watch']: {  value: 0 },
    ['bracelet']: { value: 0 },
    ['mask']: { value: 0 },


}






$(document).on('click', '.buy-btn', function (e) {
    let selectedData = $(this).parent().attr('data-type')
    if (selectedClothes[selectedData] == null && selectedClothes[selectedData] == undefined) {
        return;
    }

    selectedClothes[selectedData].selected = !selectedClothes[selectedData].selected
    if (selectedClothes[selectedData].selected) {
        $('[data-type=' + selectedData + ']').find('.buy-btn').css({ 'backgroundColor': '#f0f0f0', 'color': 'black' },)

    } else {
        $('[data-type=' + selectedData + ']').find('.buy-btn').css({ 'backgroundColor': 'rgb(61, 61, 61)', 'color': '#fff' })
    }
    setTotalPrice()


});