QBClothing = {}

var selectedTab = ".characterTab"
var lastCategory = "character"
var selectedCam = null;
var hasTracker = false;
var canChange = true;
let clothesPrices = [];
let defaultClothesPrice = null;
var clothingCategorys = [];
let totalPrice = 0;


$(document).on('click', '.clothing-menu-header-btn', function (e) {
    var category = $(this).data('category');

    $(selectedTab).removeClass("selected");
    $(this).addClass("selected");
    $(".clothing-menu-" + lastCategory + "-container").css({ "display": "none" });

    lastCategory = category;
    selectedTab = this;

    $(".clothing-menu-" + category + "-container").css({ "display": "block" });
})

QBClothing.ResetItemTexture = function (obj, category) {
    var itemTexture = $(obj).parent().parent().find('[data-type="texture"]');
    var defaultTextureValue = clothingCategorys[category].defaultTexture;
    $(itemTexture).val(defaultTextureValue);
    if (selectedClothesTextures[category]) {
        selectedClothesTextures[category].value = 0;
    }


    $.post('https://qb-clothing/updateSkin', JSON.stringify({
        clothingType: category,
        articleNumber: defaultTextureValue,
        type: "texture",
    }));
}



function setTotalPrice() {
    
    totalPrice = 0;

    for (key in selectedClothes) {
        if (selectedClothes[key].selected) {
            
            if (clothesPrices[key]) {
                if (clothesPrices[key][selectedClothes[key].value]) {
            
                    totalPrice += clothesPrices[key][selectedClothes[key].value]
                } else {
                    if (defaultClothesPrice != null) {
                        
                        totalPrice += defaultClothesPrice

                    }    
                }
            }
        }
    }


    $('.basket h1').text('Your basket is $' + totalPrice)
}

$(document).on('click', '.clothing-menu-option-item-right', function (e) {
    e.preventDefault();

    var clothingCategory = $(this).parent().parent().data('type');
    var buttonType = $(this).data('type');
    var inputElem = $(this).parent().find('input');
    var inputVal = $(inputElem).val();
    var newValue = parseFloat(inputVal) + 1;

    if (canChange) {
        if (hasTracker && clothingCategory == "accessory") {
            $.post('https://qb-clothing/TrackerError');
            return
        } else {
            if (clothingCategory == "model") {
                $(inputElem).val(newValue);
                $.post('https://qb-clothing/setCurrentPed', JSON.stringify({ ped: newValue }), function (model) {
                    $("#current-model").html("<p>" + model + "</p>")
                });
                canChange = true;
                QBClothing.ResetValues()
            } else if (clothingCategory == "hair") {
                $(inputElem).val(newValue);

                $.post('https://qb-clothing/updateSkin', JSON.stringify({
                    clothingType: clothingCategory,
                    articleNumber: newValue,
                    type: buttonType,
                }));
                if (buttonType == "item") {
                    QBClothing.ResetItemTexture(this, clothingCategory);
                }
            } else {
                if (buttonType == "item") {
                    var buttonMax = $(this).parent().find('[data-headertype="item-header"]').data('maxItem');



                    if (clothingCategory == "accessory" && newValue == 13) {
                        $(inputElem).val(14);


                        if (selectedClothes[clothingCategory]) {
                            selectedClothes[clothingCategory].value = 14;
                        }
                        setTotalPrice()

                        $.post('https://qb-clothing/updateSkin', JSON.stringify({
                            clothingType: clothingCategory,
                            articleNumber: 14,
                            type: buttonType,
                        }));
                    } else {

                        if (newValue <= parseInt(buttonMax)) {
                            $(inputElem).val(newValue);
                            if (selectedClothes[clothingCategory]) {
                                selectedClothes[clothingCategory].value = newValue;
                            }
                            setTotalPrice()

                            $.post('https://qb-clothing/updateSkin', JSON.stringify({
                                clothingType: clothingCategory,
                                articleNumber: newValue,
                                type: buttonType,
                            }));
                        }
                    }
                    QBClothing.ResetItemTexture(this, clothingCategory);
                } else {



                    var buttonMax = $(this).parent().find('[data-headertype="texture-header"]').data('maxTexture');
                    if (newValue <= parseInt(buttonMax)) {
                        $(inputElem).val(newValue);

                        if (selectedClothes[clothingCategory]) {
                            selectedClothesTextures[clothingCategory].value = newValue;
                        }

                        $.post('https://qb-clothing/updateSkin', JSON.stringify({
                            clothingType: clothingCategory,
                            articleNumber: newValue,
                            type: buttonType,
                        }));
                    }
                }
            }
        }
    }
});

$(document).on('click', '.clothing-menu-option-item-left', function (e) {
    e.preventDefault();

    var clothingCategory = $(this).parent().parent().data('type');
    var buttonType = $(this).data('type');
    var inputElem = $(this).parent().find('input');
    var inputVal = $(inputElem).val();
    var newValue = parseFloat(inputVal) - 1;

    if (canChange) {
        if (hasTracker && clothingCategory == "accessory") {
            $.post('https://qb-clothing/TrackerError');
            return
        } else {
            if (clothingCategory == "model") {
                if (newValue != 0) {
                    $(inputElem).val(newValue);
                    $.post('https://qb-clothing/setCurrentPed', JSON.stringify({ ped: newValue }), function (model) {
                        $("#current-model").html("<p>" + model + "</p>")
                    });
                    canChange = true;
                    QBClothing.ResetValues();
                }
            } else {
                if (buttonType == "item") {
                    if (newValue >= clothingCategorys[clothingCategory].defaultItem) {



                        if (clothingCategory == "accessory" && newValue == 13) {
                            $(inputElem).val(12);

                            if (selectedClothes[clothingCategory]) {
                                selectedClothes[clothingCategory].value = 12;
                            }
                            setTotalPrice()

                            $.post('https://qb-clothing/updateSkin', JSON.stringify({
                                clothingType: clothingCategory,
                                articleNumber: 12,
                                type: buttonType,
                            }));
                        } else {
                            if (selectedClothes[clothingCategory]) {
                                selectedClothes[clothingCategory].value = newValue;
                            }
                            setTotalPrice()

                            $(inputElem).val(newValue);
                            $.post('https://qb-clothing/updateSkin', JSON.stringify({
                                clothingType: clothingCategory,
                                articleNumber: newValue,
                                type: buttonType,
                            }));
                        }
                    }
                    QBClothing.ResetItemTexture(this, clothingCategory);
                } else {
                    if (newValue >= clothingCategorys[clothingCategory].defaultTexture) {



                        if (clothingCategory == "accessory" && newValue == 13) {
                            $(inputElem).val(12);

                            if (selectedClothes[clothingCategory]) {

                                selectedClothesTextures[clothingCategory].value = 12;

                            }

                            $.post('https://qb-clothing/updateSkin', JSON.stringify({
                                clothingType: clothingCategory,
                                articleNumber: 12,
                                type: buttonType,
                            }));
                        } else {
                            $(inputElem).val(newValue);
                            if (selectedClothes[clothingCategory]) {
                                selectedClothesTextures[clothingCategory].value = newValue;
                            }

                            $.post('https://qb-clothing/updateSkin', JSON.stringify({
                                clothingType: clothingCategory,
                                articleNumber: newValue,
                                type: buttonType,
                            }));
                        }
                    }
                }
            }
        }
    }
});

var changingCat = null;

function ChangeUp() {
    var clothingCategory = $(changingCat).parent().parent().data('type');
    var buttonType = $(changingCat).data('type');
    var inputVal = parseFloat($(changingCat).val());

    if (clothingCategory == "accessory" && inputVal + 1 == 13) {
        $(changingCat).val(14 - 1)
    }
}

function ChangeDown() {
    var clothingCategory = $(changingCat).parent().parent().data('type');
    var buttonType = $(changingCat).data('type');
    var inputVal = parseFloat($(changingCat).val());


    if (clothingCategory == "accessory" && inputVal - 1 == 13) {
        $(changingCat).val(12 + 1)
    }
}


$(document).on('change', '.item-slider', function () {
    var clothingCategory = $(this).parent().parent().data('type');

    let maxValue = $(this).prev().prev().data('maxItem')
    var buttonType = $(this).data('type');
    var inputVal = $(this).val();
    changingCat = this;

    if (hasTracker && clothingCategory == "accessory") {
        $.post('https://qb-clothing/TrackerError');
        if (buttonType == "item") {

            if (selectedClothes[clothingCategory]) {
                selectedClothes[clothingCategory].value = 13;
            }

        } else {
            if (selectedClothes[clothingCategory]) {


                selectedClothesTextures[clothingCategory].value = 13;

            }

        }


        $(this).val(13);
        return
    } else {
        if (clothingCategory == "accessory" && inputVal == 13) {


            if (buttonType == "item") {

                if (selectedClothes[clothingCategory]) {
                    selectedClothes[clothingCategory].value = 12;
                }
                setTotalPrice()

            } else {
                if (selectedClothes[clothingCategory]) {


                    selectedClothesTextures[clothingCategory].value = 12;

                }
                setTotalPrice()

            }
            $(this).val(12);
            return
        } else {
            if (buttonType == "item") {
                if (selectedClothes[clothingCategory]) {
                    selectedClothes[clothingCategory].value = inputVal;
                }
                setTotalPrice()

            } else {
                if (selectedClothes[clothingCategory]) {

                    selectedClothesTextures[clothingCategory].value = inputVal;

                }
                setTotalPrice()

            }
            clothingCategorys[clothingCategory].defaultItem = Number(clothingCategorys[clothingCategory].defaultItem)
            $.post('https://qb-clothing/updateSkinOnInput', JSON.stringify({
                clothingType: clothingCategory,
                articleNumber: parseFloat(inputVal),
                type: buttonType,
            }));
        }
    }

})


$(document).on('change', '.item-number', function () {
    var clothingCategory = $(this).parent().parent().data('type');

    let maxValue = $(this).prev().prev().data('maxItem')
    var buttonType = $(this).data('type');
    var inputVal = $(this).val();
    changingCat = this;

    if (hasTracker && clothingCategory == "accessory") {
        $.post('https://qb-clothing/TrackerError');

        if (buttonType == "item") {

            if (selectedClothes[clothingCategory]) {
                selectedClothes[clothingCategory].value = 13;
            }
            setTotalPrice()

        } else {
            if (selectedClothes[clothingCategory]) {


                selectedClothesTextures[clothingCategory].value = 13;

            }
            setTotalPrice()

        }
        $(this).val(13);
        return
    } else {
        if (clothingCategory == "accessory" && inputVal == 13) {
            $(this).val(12);

            if (buttonType == "item") {

                if (selectedClothes[clothingCategory]) {
                    selectedClothes[clothingCategory].value = 12;
                }
                setTotalPrice()

            } else {
                if (selectedClothes[clothingCategory]) {


                    selectedClothesTextures[clothingCategory].value = 12;

                }
                setTotalPrice()

            }
            return
        } else {

            maxValue = Number(maxValue);
            inputVal = Number(inputVal);
            clothingCategorys[clothingCategory].defaultItem = Number(clothingCategorys[clothingCategory].defaultItem)
            if (maxValue < inputVal) {
                $(this).val(maxValue);
            }

            if (clothingCategorys[clothingCategory].defaultItem > inputVal) {
                $(this).val(clothingCategorys[clothingCategory].defaultItem);
            }

            if (buttonType == "item") {
                if (selectedClothes[clothingCategory]) {
                    selectedClothes[clothingCategory].value = inputVal;
                }
            } else {
                if (selectedClothes[clothingCategory]) {

                    selectedClothesTextures[clothingCategory].value = inputVal;

                }
            }

            setTotalPrice()

            $.post('https://qb-clothing/updateSkinOnInput', JSON.stringify({
                clothingType: clothingCategory,
                articleNumber: parseFloat(inputVal),
                type: buttonType,
            }));
        }
    }
});

$(document).on('click', '.clothing-menu-header-camera-btn', function (e) {
    e.preventDefault();

    var camValue = parseFloat($(this).data('value'));

    if (selectedCam == null) {
        $(this).addClass("selected-cam");
        $.post('https://qb-clothing/setupCam', JSON.stringify({
            value: camValue
        }));
        selectedCam = this;
    } else {
        if (selectedCam == this) {
            $(selectedCam).removeClass("selected-cam");
            $.post('https://qb-clothing/setupCam', JSON.stringify({
                value: 0
            }));

            selectedCam = null;
        } else {
            $(selectedCam).removeClass("selected-cam");
            $(this).addClass("selected-cam");
            $.post('https://qb-clothing/setupCam', JSON.stringify({
                value: camValue
            }));

            selectedCam = this;
        }
    }
});

$(document).on('keydown', function () {
    switch (event.keyCode) {
        case 68: // D
            $.post('https://qb-clothing/rotateRight');
            break;
        case 65: // A
            $.post('https://qb-clothing/rotateLeft');
            break;
        case 38: // UP
            ChangeUp();
            break;
        case 40: // DOWN
            ChangeDown();
            break;
    }
});

QBClothing.ToggleChange = function (bool) {
    canChange = bool;
}

$(document).ready(function () {
    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case "open":
                QBClothing.Open(event.data);
                clothesPrices = event.data.clothesPrices;
                defaultClothesPrice = event.data.defaultPrice;
                break;
            case "close":
                QBClothing.Close();
                break;
            case "updateMax":
                QBClothing.SetMaxValues(event.data.maxValues);
                break;
            case "reloadMyOutfits":
                QBClothing.ReloadOutfits(event.data.outfits);
                break;
            case "toggleChange":
                QBClothing.ToggleChange(event.data.allow);
                break;
            case "ResetValues":
                QBClothing.ResetValues();
                break;
        }
    })
});

QBClothing.ReloadOutfits = function (outfits) {
    $(".clothing-menu-myOutfits-container").html("");
    $.each(outfits, function (index, outfit) {
        var elem = '<div class="clothing-menu-option" data-myOutfit="' + (index + 1) + '"> <div class="clothing-menu-option-header"><p>' + outfit.outfitname + '</p></div><div class="clothing-menu-myOutfit-option-button"><p>Select</p></div><div class="clothing-menu-myOutfit-option-button-remove"><p>Delete</p></div></div>'
        $(".clothing-menu-myOutfits-container").append(elem)

        $("[data-myOutfit='" + (index + 1) + "']").data('myOutfitData', outfit)
    });
}

$(document).on('click', "#save-menu", function (e) {
    e.preventDefault();
    let count = 0;
    for (key in selectedClothes) {

        if (selectedClothes[key].selected) {

            count++;
        }

        if (count >= 3) {
            $('.clothing-menu-select-packaged').fadeIn()
            return;
        }
    }

    if(count == 0){
        $('.clothing-menu-noclothes').fadeIn()
        return

    }

    $.post('https://qb-clothing/saveClothing', JSON.stringify({
        selectedClothes: selectedClothes,
        selectedTextures: selectedClothesTextures,
        packaged:false,
        totalPrice: totalPrice,
    }));



    QBClothing.Close();
    setTimeout(() => {

        for (key in selectedClothes) {
            selectedClothes[key].selected = false;
            selectedClothes[key].value = 0
        }

        for (key in selectedClothesTextures) {
            selectedClothesTextures[key].selected = false;
            selectedClothesTextures[key].value = 0
        }
        setTotalPrice()

    }, 1000)

    $('.buy-btn').css({ 'backgroundColor': 'rgb(61, 61, 61)', 'color': '#fff' })


});

$(document).on('click', "#decline-noclothes", function (e) {
    $('.clothing-menu-noclothes').fadeOut()

})

$(document).on('click', "#accept-noclothes", function (e) {
    $('.clothing-menu-noclothes').fadeOut()
    $.post('https://qb-clothing/saveClothing', JSON.stringify({
        selectedClothes: selectedClothes,
        selectedTextures: selectedClothesTextures,
        packaged: false,
        totalPrice: totalPrice,
    }));

    QBClothing.Close();

    setTimeout(() => {
        for (key in selectedClothes) {
            selectedClothes[key].selected = false;
            selectedClothes[key].value = 0
        }

        for (key in selectedClothesTextures) {
            selectedClothesTextures[key].selected = false;
            selectedClothesTextures[key].value = 0
        }
        setTotalPrice()

    }, 1000)
    $('.buy-btn').css({ 'backgroundColor': 'rgb(61, 61, 61)', 'color': '#fff' })
})


$(document).on('click', "#accept-packaged", function (e) {

    $.post('https://qb-clothing/saveClothing', JSON.stringify({
        selectedClothes: selectedClothes,
        selectedTextures: selectedClothesTextures,
        packaged: true,
        totalPrice: totalPrice,
    }));

    QBClothing.Close();

    setTimeout(() => {
        for (key in selectedClothes) {
            selectedClothes[key].selected = false;
            selectedClothes[key].value = 0
        }

        for (key in selectedClothesTextures) {
            selectedClothesTextures[key].selected = false;
            selectedClothesTextures[key].value = 0
        }
        setTotalPrice()

    }, 1000)
    $('.buy-btn').css({ 'backgroundColor': 'rgb(61, 61, 61)', 'color': '#fff' })

})


$(document).on('click', "#decline-packaged", function (e) {

    $.post('https://qb-clothing/saveClothing', JSON.stringify({
        selectedClothes: selectedClothes,
        selectedTextures: selectedClothesTextures,
        packaged: false,

        totalPrice: totalPrice,

    }));

    QBClothing.Close();

    setTimeout(() => {

        for (key in selectedClothes) {
            selectedClothes[key].selected = false;
            selectedClothes[key].value = 0
        }

        for (key in selectedClothesTextures) {
            selectedClothesTextures[key].selected = false;
            selectedClothesTextures[key].value = 0
        }
        setTotalPrice()

    }, 1000)
    $('.buy-btn').css({ 'backgroundColor': 'rgb(61, 61, 61)', 'color': '#fff' })

})



$(document).on('click', "#cancel-menu", function (e) {
    e.preventDefault();
    $.post('https://qb-clothing/resetOutfit');

    QBClothing.Close();
    setTimeout(() => {

        for (key in selectedClothes) {
            selectedClothes[key].selected = false;
            selectedClothes[key].value = 0
        }

        for (key in selectedClothesTextures) {
            selectedClothesTextures[key].selected = false;
            selectedClothesTextures[key].value = 0
        }
        setTotalPrice()

    }, 1000)
});

QBClothing.SetCurrentValues = function (clothingValues) {
    $.each(clothingValues, function (i, item) {
        var itemCats = $(".clothing-menu-container").find('[data-type="' + i + '"]');
		 if (i == "facemix") { //Added for special case with range sliders
            $('#shapeMix').val(item.shapeMix);
            $('#skinMix').val(item.skinMix);
        } else {
        var input = $(itemCats).find('input[data-type="item"]');
        var texture = $(itemCats).find('input[data-type="texture"]');

        $(input).val(item.item);
        $(texture).val(item.texture);
		}
    });
}

QBClothing.Open = function (data) {
    clothingCategorys = data.currentClothing;
    for (key in selectedClothes) {

        if (clothingCategorys[key]) {
            selectedClothes[key].value = clothingCategorys[key].item
            selectedClothesTextures[key].value = clothingCategorys[key].texture
        }
    }

    
    if (data.hasTracker) {
        hasTracker = true;
    } else {
        hasTracker = false;
    }

    $(".change-camera-buttons").fadeIn(150);
    $('.basket').css('display', 'block')
    $(".clothing-menu-roomOutfits-container").css("display", "none");
    $(".clothing-menu-myOutfits-container").css("display", "none");
    $(".clothing-menu-character-container").css("display", "none");
    $(".clothing-menu-clothing-container").css("display", "none");
    $(".clothing-menu-accessoires-container").css("display", "none");
    $(".clothing-menu-singleArm-container").css("display", "none");
    
    $('.help-info').css('display', 'block')

    $(".clothing-menu-container").css({ "display": "block" }).animate({ right: 0, }, 200);
    QBClothing.SetMaxValues(data.maxValues);
    $(".clothing-menu-header").html("");
    QBClothing.SetCurrentValues(data.currentClothing);
    $(".clothing-menu-roomOutfits-container").html("");
    $(".clothing-menu-myOutfits-container").html("");
    $.each(data.menus, function (i, menu) {
        if (menu.selected) {
            $(".clothing-menu-header").append('<div class="clothing-menu-header-btn ' + menu.menu + 'Tab selected" data-category="' + menu.menu + '"><p>' + menu.label + '</p></div>')
            $(".clothing-menu-" + menu.menu + "-container").css({ "display": "block" });
			if (menu.label == "Clothing") {
                $("#faceoption").css("display", "none");
            } else {
                $("#faceoption").css("display", "block");
            }
            selectedTab = "." + menu.menu + "Tab";
            lastCategory = menu.menu;

        } else {
            $(".clothing-menu-header").append('<div class="clothing-menu-header-btn ' + menu.menu + 'Tab" data-category="' + menu.menu + '"><p>' + menu.label + '</p></div>')
        }

        if (menu.menu == "roomOutfits") {
            $.each(menu.outfits, function (index, outfit) {
                var elem = '<div class="clothing-menu-option" data-outfit="' + (index + 1) + '"> <div class="clothing-menu-option-header"><p>' + outfit.outfitLabel + '</p></div> <div class="clothing-menu-outfit-option-button"><p>Select Outfit</p></div> </div>'
                $(".clothing-menu-roomOutfits-container").append(elem)

                $("[data-outfit='" + (index + 1) + "']").data('outfitData', outfit)
            });
        }

        if (menu.menu == "myOutfits") {
            $.each(menu.outfits, function (index, outfit) {
                var elem = '<div class="clothing-menu-option" data-myOutfit="' + (index + 1) + '"> <div class="clothing-menu-option-header"><p>' + outfit.outfitname + '</p></div><div class="clothing-menu-myOutfit-option-button"><p>Select</p></div><div class="clothing-menu-myOutfit-option-button-remove"><p>Delete</p></div></div>'
                $(".clothing-menu-myOutfits-container").append(elem)

                $("[data-myOutfit='" + (index + 1) + "']").data('myOutfitData', outfit)
            });
        }
    });

    var menuWidth = (100 / data.menus.length)

    $(".clothing-menu-header-btn").css("width", menuWidth + "%");
}

$(document).on('click', '.clothing-menu-outfit-option-button', function (e) {
    e.preventDefault();

    var oData = $(this).parent().data('outfitData');

    $.post('https://qb-clothing/selectOutfit', JSON.stringify({
        outfitData: oData.outfitData,
        outfitName: oData.outfitLabel
    }))
});

$(document).on('click', '.clothing-menu-myOutfit-option-button', function (e) {
    e.preventDefault();

    var outfitData = $(this).parent().data('myOutfitData');

    $.post('https://qb-clothing/selectOutfit', JSON.stringify({
        outfitData: outfitData.skin,
        outfitName: outfitData.outfitname,
        outfitId: outfitData.outfitId,
    }))
});

$(document).on('click', '.clothing-menu-myOutfit-option-button-remove', function (e) {
    e.preventDefault();

    var outfitData = $(this).parent().data('myOutfitData');

    $.post('https://qb-clothing/removeOutfit', JSON.stringify({
        outfitData: outfitData.skin,
        outfitName: outfitData.outfitname,
        outfitId: outfitData.outfitId,
    }));
});

QBClothing.Close = function () {

    $('.basket').css('display', 'none')

    $('.help-info').css('display', 'none')

    $.post('https://qb-clothing/close');
    $(".change-camera-buttons").fadeOut(150);
    $('.clothing-menu-select-packaged').fadeOut(150)
    $('.clothing-menu-noclothes').fadeOut(150)


    $(".clothing-menu-roomOutfits-container").css("display", "none");
    $(".clothing-menu-myOutfits-container").css("display", "none");
    $(".clothing-menu-character-container").css("display", "none");
    $(".clothing-menu-clothing-container").css("display", "none");
    $(".clothing-menu-accessoires-container").css("display", "none");
    $(".clothing-menu-singleArm-container").css("display", "none");

    $(".clothing-menu-header").html("");

    $(selectedCam).removeClass('selected-cam');
    $(selectedTab).removeClass("selected");
    selectedCam = null;
    selectedTab = null;
    lastCategory = null;
    $(".clothing-menu-container").css({ "display": "block" }).animate({ right: "-25vw", }, 200, function () {
        $(".clothing-menu-container").css({ "display": "none" });
    });
}

QBClothing.SetMaxValues = function (maxValues) {
    $.each(maxValues, function (i, cat) {
        if (cat.type == "character") {
            var containers = $(".clothing-menu-character-container").find('[data-type="' + i + '"]');
            var itemMax = $(containers).find('[data-headertype="item-header"]');
            var headerMax = $(containers).find('[data-headertype="texture-header"]');

            $(itemMax).data('maxItem', maxValues[containers.attr('data-type')].item)
            $(headerMax).data('maxTexture', maxValues[containers.data('type')].texture)

            $(itemMax).html("<p>Item: " + maxValues[containers.data('type')].item + "</p>")
            $(headerMax).html("<p>Texture: " + maxValues[containers.data('type')].texture + "</p>")
        } else if (cat.type == "hair") {
            var containers = $(".clothing-menu-clothing-container").find('[data-type="' + i + '"]');
            var itemMax = $(containers).find('[data-headertype="item-header"]');
            if (containers.parent().parent().attr('data-clothingtype') == 'face_feature') {
                containers.attr('min', -30)

                containers.attr('max', 30)

            }
            var headerMax = $(containers).find('[data-headertype="texture-header"]');
            $(itemMax).data('maxItem', maxValues[containers.attr('data-type')].item)
            $(headerMax).data('maxTexture', maxValues[containers.data('type')].texture)

            $(itemMax).html("<p>Item: " + maxValues[containers.data('type')].item + "</p>")
            $(headerMax).html("<p>Texture: " + maxValues[containers.data('type')].texture + "</p>")
        } else if (cat.type == "accessoires") {
            var containers = $(".clothing-menu-accessoires-container").find('[data-type="' + i + '"]');
            var itemMax = $(containers).find('[data-headertype="item-header"]');
            var headerMax = $(containers).find('[data-headertype="texture-header"]');

            $(itemMax).data('maxItem', maxValues[containers.data('type')].item)
            $(headerMax).data('maxTexture', maxValues[containers.data('type')].texture)

            $(itemMax).html("<p>Item: " + maxValues[containers.data('type')].item + "</p>")
            $(headerMax).html("<p>Texture: " + maxValues[containers.data('type')].texture + "</p>")
        } else if(cat.type == 'singleArm'){
            var containers = $(".clothing-menu-singleArm-container").find('[data-type="' + i + '"]');
            var itemMax = $(containers).find('[data-headertype="item-header"]');
            var headerMax = $(containers).find('[data-headertype="texture-header"]');
            $(itemMax).data('maxItem', maxValues[containers.attr('data-type')].item)
            $(headerMax).data('maxTexture', maxValues[containers.data('type')].texture)

            $(itemMax).html("<p>Item: " + maxValues[containers.data('type')].item + "</p>")
            $(headerMax).html("<p>Texture: " + maxValues[containers.data('type')].texture + "</p>")
        }
    })
}

QBClothing.ResetValues = function () {
    $.each(clothingCategorys, function (i, cat) {
        var itemCats = $(".clothing-menu-container").find('[data-type="' + i + '"]');
        var input = $(itemCats).find('input[data-type="item"]');
        var texture = $(itemCats).find('input[data-type="texture"]');

        if (selectedClothesTextures[cat]) {
            selectedClothesTextures[cat].value = cat.defaultItem;
            selectedClothes[cat].value = cat.defaultTexture;
        }

        setTotalPrice()


        $(input).val(cat.defaultItem);
        $(texture).val(cat.defaultTexture);
    })
}

$(document).on('click', '#save-outfit', function (e) {
    e.preventDefault();

    $(".clothing-menu-container").css({ "display": "block" }).animate({ right: "-25vw", }, 200, function () {
        $(".clothing-menu-container").css({ "display": "none" });
    });

    $(".clothing-menu-save-outfit-name").fadeIn(150);
});

$(document).on('click', '#save-outfit-save', function (e) {
    e.preventDefault();

    $(".clothing-menu-container").css({ "display": "block" }).animate({ right: 0, }, 200);
    $(".clothing-menu-save-outfit-name").fadeOut(150);

    $.post('https://qb-clothing/saveOutfit', JSON.stringify({
        outfitName: $("#outfit-name").val()
    }));
});

$(document).on('click', '#cancel-outfit-save', function (e) {
    e.preventDefault();

    $(".clothing-menu-container").css({ "display": "block" }).animate({ right: 0, }, 200);
    $(".clothing-menu-save-outfit-name").fadeOut(150);
});

$(document).on('click', '.change-camera-button', function (e) {
    e.preventDefault();

    var rotationType = $(this).data('rotation');

    $.post('https://qb-clothing/rotateCam', JSON.stringify({
        type: rotationType
    }))
});

// QBClothing.Open()