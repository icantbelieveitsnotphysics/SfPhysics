module SfMaterials

using Unitful, ..SfMatter

aluminium = Material(2.7u"g/cm^3", 270u"MPa") # yield strength for 6061 alloy, https://en.wikipedia.org/wiki/6061_aluminium_alloy
iron = Material(7.874u"g/cm^3")
steel = Material(7700u"kg/m^3", 350u"MPa") # 1020 steel, http://www.matweb.com/search/datasheet.aspx?bassnum=MS0001
titanium = Material(4.506u"g/cm^3", 140u"MPa") # http://www.matweb.com/search/datasheet.aspx?bassnum=METi00&ckck=1
titanium_alloy = Material(4.51u"g/cm^3", 830u"MPa") # 6% Al, 4% V, https://en.wikipedia.org/wiki/Yield_(engineering)
tungsten = Material(19.25u"g/cm^3", 550u"MPa") # annealed, https://en.wikipedia.org/wiki/Yield_(engineering)
water = Material(997u"kg/m^3", 0u"Pa")
ice = Material(0.9168u"g/cm^3", 0u"Pa")

end
