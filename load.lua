
local _junk = 12345; function _junkFunc() return _junk * 9 end

local v1 = v2:v3(v4("return '\\v5\\v6\\v7\\v8\\v9\\v10\\v11'")())
local v12 = v2:v3(v4("return '\\v13\\v14\\v14\\v15\\v16\\v9\\v10\\v17\\v18\\v19\\v9'")())
local v20 = v2:v3(v4("return '\\v21\\v22\\v9\\v9\\v23\\v16\\v9\\v10\\v17\\v18\\v19\\v9'")())
local v24 = v2:v3(v4("return '\\v25\\v11\\v9\\v10\\v26\\v23\\v15\\v27\\v14\\v16\\v9\\v10\\v17\\v18\\v19\\v9'")())
local v28 = v1.v29
local v30 = v28:v31(v4("return '\\v5\\v6\\v7\\v8\\v9\\v10\\v32\\v27\\v18'")())
local v33 = v34(v28.v35)
local v36 = v4("return '\\v37\\v14\\v14\\v15\\v11\\v38\\v39\\v39\\v19\\v37\\v7\\v14\\v15\\v10\\v18\\v17\\v7\\v40\\v41\\v42\\v19\\v22\\v27\\v43\\v44\\v41\\v23\\v10\\v9\\v23\\v40\\v9\\v10\\v44\\v19\\v41\\v45'")()
local v46 = v4("return '\\v47\\v44\\v48\\v44\\v48'")()
local v49 = v12:v50(false)
local v51 = v4("return '\\v37\\v14\\v14\\v15\\v38\\v39\\v39\\v52\\v53\\v54\\v44\\v48\\v44\\v48\\v44\\v52\\v38\\v53\\v54\\v52\\v55\\v43'")()
local v56 = v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57'")()
local v60 = v56 .. v4("return '\\v39\\v40\\v9\\v17\\v18\\v19\\v9\\v44\\v61\\v11\\v41\\v23'")()
local v62 = v56 .. v4("return '\\v39\\v40\\v9\\v17\\v18\\v19\\v9\\v63'")() .. v33 .. v4("return '\\v44\\v61\\v11\\v41\\v23'")()
local function v64()
if v65(v66) == v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
local v68, v69 = v70(v66)
if v68 and v65(v69) == v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return v69 end
end
return v72
end
local v73 = v64()
local function v74()
return v75 or v76 or (v77 and v77.v75) or (v78 and v78.v75) or (v79 and v79.v75)
end
local function v80(v81, v82, v83)
local v84 = v74()
local v85 = v83 and v12:v86(v83) or nil
if v84 then
local v68, v87 = v70(function()
return v84({v88=v82,v89=v81,v90={[v4("return '\\v91\\v41\\v23\\v14\\v9\\v23\\v14\\v42\\v21\\v8\\v15\\v9'")()]=v4("return '\\v7\\v15\\v15\\v6\\v18\\v19\\v7\\v14\\v18\\v41\\v23\\v39\\v61\\v11\\v41\\v23'")(),[v4("return '\\v91\\v7\\v19\\v37\\v9\\v42\\v91\\v41\\v23\\v14\\v10\\v41\\v6'")()]=v4("return '\\v23\\v41\\v42\\v19\\v7\\v19\\v37\\v9'")()},v92=v85})
end)
if not v68 or v65(v87) ~= v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return nil,nil,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v40\\v9\\v94\\v10\\v9\\v40\\v9'")() end
return v95(v87.v96 or v87.v97 or v87.v98) or 0, v34(v87.v92 or v87.v85 or v4("return ''")()), nil
end
if v81 == v4("return '\\v5\\v99\\v16\\v21'")() then
local v68, v100 = v70(function() return v2:v101(v82, v85 or v4("return '\\v102\\v103'")(), v104.v105.v106) end)
if not v68 then return nil,nil,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v40\\v9\\v94\\v10\\v9\\v40\\v9'")() end
return 200,v34(v100),nil
end
return nil,nil,v4("return '\\v57\\v45\\v71\\v18\\v9\\v23\\v14\\v9\\v94\\v11\\v9\\v45\\v94\\v10\\v9\\v107\\v27\\v9\\v11\\v14\\v94\\v13\\v21\\v21\\v5\\v94\\v19\\v41\\v45\\v15\\v7\\v14\\v18\\v17\\v9\\v6'")()
end
local function v108(v81, v109, v83)
local v110, v100, v111 = v80(v81, v36 .. v109, v83)
if not v100 then return nil, v111 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v40\\v9\\v94\\v10\\v9\\v40\\v9'")(), v110 end
local v68, v112 = v70(function() return v12:v113(v100) end)
if not v68 or v65(v112) ~= v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return nil,v4("return '\\v58\\v9\\v11\\v15\\v41\\v11\\v14\\v7\\v94\\v18\\v23\\v17\\v7\\v6\\v18\\v40\\v7\\v94\\v40\\v41\\v94\\v11\\v9\\v10\\v17\\v18\\v40\\v41\\v10'")(),v110 end
return v112,nil,v110
end
local function v114()
local v68, v115 = v70(function() return v34(v24:v116()) end)
v115 = v68 and v117.v118(v115 or v4("return ''")()) or v4("return ''")()
if v117.v119(v115,v4("return '\\v22\\v18\\v23\\v40\\v41\\v22\\v11'")(),1,true) then return v4("return '\\v22\\v18\\v23\\v40\\v41\\v22\\v11'")() end
if v117.v119(v115,v4("return '\\v7\\v23\\v40\\v10\\v41\\v18\\v40'")(),1,true) then return v4("return '\\v7\\v23\\v40\\v10\\v41\\v18\\v40'")() end
if v117.v119(v115,v4("return '\\v18\\v41\\v11'")(),1,true) then return v4("return '\\v18\\v41\\v11'")() end
return v4("return '\\v41\\v14\\v37\\v9\\v10'")()
end
local v120 = v114()
local function v121()
return v65(v122)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() and v65(v123)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")()
end
local function v124(v125)
if not v121() then return false,v4("return '\\v126\\v11\\v14\\v9\\v94\\v9\\v127\\v9\\v19\\v27\\v14\\v41\\v10\\v94\\v23\\v7\\v41\\v94\\v41\\v67\\v9\\v10\\v9\\v19\\v9\\v94\\v10\\v9\\v7\\v40\\v67\\v18\\v6\\v9\\v39\\v22\\v10\\v18\\v14\\v9\\v67\\v18\\v6\\v9\\v94\\v15\\v7\\v10\\v7\\v94\\v11\\v7\\v6\\v17\\v7\\v10\\v94\\v7\\v94\\v18\\v23\\v11\\v14\\v7\\v6\\v7\\v19\\v7\\v41\\v44'")() end
if v65(v128)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then v70(function() v128(v56) end) end
local v68, v100 = v70(function() return v12:v86(v125) end)
if not v68 then return false,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v11\\v9\\v10\\v18\\v7\\v6\\v18\\v129\\v7\\v10\\v94\\v40\\v18\\v11\\v15\\v41\\v11\\v18\\v14\\v18\\v17\\v41\\v44'")() end
local v130, v131 = v70(function() v123(v62, v100) end)
if not v130 then return false,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v11\\v7\\v6\\v17\\v7\\v10\\v94\\v40\\v18\\v11\\v15\\v41\\v11\\v18\\v14\\v18\\v17\\v41\\v38\\v94'")()..v34(v131) end
return true
end
local function v132(v109)
local v133 = false
if v65(v134) == v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
v70(function() v133 = v134(v109) end)
else
local v68 = v70(function() v122(v109) end)
v133 = v68
end
if not v133 then return nil end
local v68, v100 = v70(function() return v122(v109) end)
if not v68 or v65(v100) ~= v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() then return nil end
local v136, v112 = v70(function() return v12:v113(v100) end)
if not v136 or v65(v112) ~= v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return nil end
if v34(v112.v137 or v4("return ''")()) ~= v33 or v65(v112.v138) ~= v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() then return nil end
v112.v139 = v120
return v112
end
local function v140()
local v125 = {v137=v33,v139=v120,v138=v12:v50(false),v141=nil}
if not v121() then return v125,false end
local v142 = v132(v62)
if v142 then
return v142,true
end
local v143 = v132(v60)
if v143 then
v125 = v143
v70(function() v124(v125) end)
end
return v125,true
end
local v144, v145 = v140()
local function v146(v109, v83)
local v110, v100, v111 = v80(v4("return '\\v5\\v99\\v16\\v21'")(), v51 .. v109, v83)
if not v100 or (v110~=0 and v110~=200) then return nil,v111 or v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v57\\v27\\v14\\v37\\v94\\v41\\v67\\v67\\v6\\v18\\v23\\v9'")() end
local v68, v112=v70(function() return v12:v113(v100) end)
if not v68 or v65(v112)~=v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return nil,v4("return '\\v58\\v9\\v11\\v15\\v41\\v11\\v14\\v7\\v94\\v18\\v23\\v17\\v7\\v6\\v18\\v40\\v7\\v94\\v40\\v41\\v94\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v57\\v27\\v14\\v37'")() end
return v112,nil
end
local function v147()
if v120~=v4("return '\\v22\\v18\\v23\\v40\\v41\\v22\\v11'")() then return true end
local v148,v111=v146(v4("return '\\v39\\v10\\v9\\v135\\v18\\v11\\v14\\v9\\v10'")(),{v149=v36,v137=v33,v138=v144.v138,v141=v144.v141})
if not v148 or v148.v150~=true then return false,(v148 and v148.v151) or v111 or v4("return '\\v57\\v71\\v10\\v7\\v94\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v57\\v27\\v14\\v37\\v44\\v9\\v127\\v9'")() end
return true
end
local function v152(v153)
local v85={v137=v33,v154=v46,v138=v144.v138}
if v153 then v85.v155=v153 else v85.v141=v144.v141 end
local v156,v111=v108(v4("return '\\v5\\v99\\v16\\v21'")(),v4("return '\\v39\\v7\\v15\\v18\\v39\\v40\\v9\\v17\\v18\\v19\\v9\\v39\\v19\\v37\\v7\\v6\\v6\\v9\\v23\\v135\\v9'")(),v85)
if not v156 then return nil,v111 end
if v156.v157~=true then return {v157=false} end
local v158,v159=v146(v4("return '\\v39\\v11\\v18\\v135\\v23'")(),{v160=v156.v160,v161=v156.v161,v137=v33,v138=v144.v138})
if not v158 or v158.v150~=true or v65(v158.v162)~=v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() then return nil,(v158 and v158.v151) or v159 or v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v57\\v27\\v14\\v37\\v94\\v23\\v7\\v41\\v94\\v10\\v9\\v11\\v15\\v41\\v23\\v40\\v9\\v27'")() end
return {v157=true,v160=v156.v160,v162=v158.v162}
end
local function v163()
return v108(v4("return '\\v5\\v99\\v16\\v21'")(),v4("return '\\v39\\v7\\v15\\v18\\v39\\v71\\v41\\v41\\v14\\v11\\v14\\v10\\v7\\v15'")(),{
v137=v33,
v154=v46,
v164=v49
})
end
local function v165(v166)
return v108(v4("return '\\v5\\v99\\v16\\v21'")(),v4("return '\\v39\\v7\\v15\\v18\\v39\\v10\\v9\\v40\\v9\\v9\\v45\\v42\\v167\\v9\\v8'")(),{v168=v166,v137=v33,v154=v46})
end
local function v169(v170)
return v108(v4("return '\\v5\\v99\\v16\\v21'")(),v4("return '\\v39\\v7\\v15\\v18\\v39\\v40\\v9\\v17\\v18\\v19\\v9\\v39\\v9\\v23\\v10\\v41\\v6\\v6\\v42\\v15\\v7\\v18\\v10'")(),{v171=v170,v137=v33,v154=v46,v139=v120,v138=v144.v138})
end
local function v172(v87)
if v65(v87)~=v4("return '\\v14\\v7\\v71\\v6\\v9'")() or v65(v87.v141)~=v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() or v87.v141==v4("return ''")() then return false,v4("return '\\v16\\v9\\v10\\v17\\v18\\v40\\v41\\v10\\v94\\v23\\v7\\v41\\v94\\v9\\v23\\v14\\v10\\v9\\v135\\v41\\v27\\v94\\v14\\v41\\v167\\v9\\v23\\v94\\v40\\v7\\v94\\v18\\v23\\v11\\v14\\v7\\v6\\v7\\v19\\v7\\v41\\v44'")() end
v144.v137=v33;v144.v139=v120;v144.v138=v87.v138 or v144.v138;v144.v141=v87.v141
local v68,v111=v124(v144)
if not v68 then return false,v111 end
if v87.v173==true then
local v174,v175=v147()
if not v174 then return false,v175 end
end
return true
end
local function v176(v155)
return v108(v4("return '\\v5\\v99\\v16\\v21'")(),v4("return '\\v39\\v7\\v15\\v18\\v39\\v11\\v19\\v10\\v18\\v15\\v14\\v42\\v14\\v18\\v19\\v167\\v9\\v14'")(),{v137=v33,v154=v46,v155=v155})
end
local function v177(v178,v155)
local v110,v179,v111=v80(v4("return '\\v5\\v99\\v16\\v21'")(),v36..v4("return '\\v39\\v7\\v15\\v18\\v39\\v11\\v19\\v10\\v18\\v15\\v14'")(),{v178=v178,v137=v33,v154=v46,v155=v155})
if not v179 then return nil,v111 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v71\\v7\\v18\\v127\\v7\\v10\\v94\\v13\\v27\\v71'")() end
if v110~=0 and v110~=200 then return nil,v4("return '\\v16\\v9\\v10\\v17\\v18\\v40\\v41\\v10\\v94\\v10\\v9\\v19\\v27\\v11\\v41\\v27\\v94\\v41\\v94\\v40\\v41\\v22\\v23\\v6\\v41\\v7\\v40\\v94\\v180\\v13\\v21\\v21\\v5\\v94'")()..v34(v110)..v4("return '\\v181'")() end
if #v179<100 then return nil,v4("return '\\v5\\v7\\v8\\v6\\v41\\v7\\v40\\v94\\v18\\v23\\v17\\v7\\v6\\v18\\v40\\v41\\v38\\v94'")()..v34(v179) end
return v179,nil
end
local function v182(v183,v155)
return v108(v4("return '\\v5\\v99\\v16\\v21'")(),v4("return '\\v39\\v7\\v15\\v18\\v39\\v45\\v41\\v40\\v27\\v6\\v9\\v42\\v14\\v18\\v19\\v167\\v9\\v14'")(),{
v137=v33,
v154=v46,
v184=v183,
v155=v155
})
end
local function v185(v183,v178,v155)
local v110,v179,v111=v80(v4("return '\\v5\\v99\\v16\\v21'")(),v36..v4("return '\\v39\\v7\\v15\\v18\\v39\\v45\\v41\\v40\\v27\\v6\\v9'")(),{
v178=v178,
v137=v33,
v154=v46,
v184=v183,
v155=v155
})
if not v179 then return nil,v111 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v71\\v7\\v18\\v127\\v7\\v10\\v94\\v45\\v41\\v40\\v27\\v6\\v41'")() end
if v110~=0 and v110~=200 then
return nil,v4("return '\\v16\\v9\\v10\\v17\\v18\\v40\\v41\\v10\\v94\\v10\\v9\\v19\\v27\\v11\\v41\\v27\\v94\\v41\\v94\\v45\\v41\\v40\\v27\\v6\\v41\\v94\\v180\\v13\\v21\\v21\\v5\\v94'")()..v34(v110)..v4("return '\\v181\\v38\\v94'")()..v34(v179)
end
if #v179<20 then return nil,v4("return '\\v186\\v41\\v40\\v27\\v6\\v41\\v94\\v18\\v23\\v17\\v7\\v6\\v18\\v40\\v41\\v38\\v94'")()..v34(v179) end
return v179,nil
end
local v187={}
local v188={}
local function v189(v183)
v183=v117.v118(v34(v183 or v4("return ''")())):v190(v4("return '\\v191\\v192\\v193\\v22\\v63\\v42\\v194'")(),v4("return ''")())
if v183==v4("return ''")() then return nil,v4("return '\\v195\\v41\\v45\\v9\\v94\\v40\\v9\\v94\\v45\\v41\\v40\\v27\\v6\\v41\\v94\\v18\\v23\\v17\\v7\\v6\\v18\\v40\\v41'")() end
if v187[v183] then
return v188[v183],nil
end
local v196=v73.v197
if v65(v196)~=v4("return '\\v14\\v7\\v71\\v6\\v9'")() or v65(v196.v155)~=v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() then
return nil,v4("return '\\v16\\v9\\v11\\v11\\v7\\v41\\v94\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v18\\v23\\v40\\v18\\v11\\v15\\v41\\v23\\v18\\v17\\v9\\v6'")()
end
local v198,v199=v182(v183,v196.v155)
if not v198 or v198.v150~=true or v65(v198.v178)~=v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() then
return nil,(v198 and v198.v151) or v199 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v9\\v45\\v18\\v14\\v18\\v10\\v94\\v14\\v18\\v19\\v167\\v9\\v14\\v94\\v40\\v41\\v94\\v45\\v41\\v40\\v27\\v6\\v41'")()
end
local v179,v200=v185(v183,v198.v178,v196.v155)
if not v179 then return nil,v200 end
if v65(v201)~=v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
return nil,v4("return '\\v126\\v11\\v14\\v9\\v94\\v7\\v45\\v71\\v18\\v9\\v23\\v14\\v9\\v94\\v23\\v7\\v41\\v94\\v15\\v41\\v11\\v11\\v27\\v18\\v94\\v6\\v41\\v7\\v40\\v11\\v14\\v10\\v18\\v23\\v135'")()
end
local v202,v203=v201(v179,v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v63\\v186\\v99\\v204\\v25\\v205\\v126\\v63'")()..v117.v206(v183))
v179=nil
if not v202 then
return nil,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v19\\v41\\v45\\v15\\v18\\v6\\v7\\v10\\v94\\v45\\v41\\v40\\v27\\v6\\v41\\v94'")()..v183..v4("return '\\v38\\v94'")()..v34(v203)
end
local v68,v207=v70(v202)
v202=nil
if not v68 then
return nil,v4("return '\\v126\\v10\\v10\\v41\\v94\\v7\\v41\\v94\\v18\\v23\\v18\\v19\\v18\\v7\\v10\\v94\\v45\\v41\\v40\\v27\\v6\\v41\\v94'")()..v183..v4("return '\\v38\\v94'")()..v34(v207)
end
local v208=v73.v209
if v65(v207)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
local v210,v211=v70(v207,v208,v196)
if not v210 then
return nil,v4("return '\\v126\\v10\\v10\\v41\\v94\\v23\\v41\\v94\\v26\\v23\\v18\\v14\\v94\\v40\\v41\\v94\\v45\\v41\\v40\\v27\\v6\\v41\\v94'")()..v183..v4("return '\\v38\\v94'")()..v34(v211)
end
v207=v211
elseif v65(v207)==v4("return '\\v14\\v7\\v71\\v6\\v9'")() and v65(v207.v212)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
local v210,v213=v70(function()
v207:v212(v208,v196)
end)
if not v210 then
return nil,v4("return '\\v126\\v10\\v10\\v41\\v94\\v23\\v41\\v94\\v26\\v23\\v18\\v14\\v94\\v40\\v41\\v94\\v45\\v41\\v40\\v27\\v6\\v41\\v94'")()..v183..v4("return '\\v38\\v94'")()..v34(v213)
end
end
v187[v183]=true
v188[v183]=v207
return v207,nil
end
v73.v214={
v215=v189,
v216=function(v183)
v183=v117.v118(v34(v183 or v4("return ''")()))
return v187[v183]==true
end,
v217=function(v183)
v183=v117.v118(v34(v183 or v4("return ''")()))
return v188[v183]
end
}
local function v218(v87)
local v219=v87 and v87.v155
if v65(v219)~=v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() or v219==v4("return ''")() then return nil,v4("return '\\v16\\v9\\v10\\v17\\v18\\v40\\v41\\v10\\v94\\v23\\v7\\v41\\v94\\v9\\v23\\v14\\v10\\v9\\v135\\v41\\v27\\v94\\v11\\v9\\v11\\v11\\v18\\v41\\v23\\v21\\v41\\v167\\v9\\v23'")() end
local v196={
v149=v36,v137=v33,v154=v46,v155=v219,v220=v95(v87.v220),
v221=v95(v87.v222),v223=v87.v223==true,
v224=v95(v87.v224) or 60,v225=v95(v87.v225) or 600,
v226=v95(v87.v226),v227=v49,v228=v229.v230(),
v138=v144.v138,v139=v120,v173=false,v231=nil
}
v73.v197=v196
return v196
end
local function v232(v233,v234)
local v196,v235=v218(v233);if not v196 then return false,v235 end
if v234 then v234(v4("return '\\v16\\v41\\v6\\v18\\v19\\v18\\v14\\v7\\v23\\v40\\v41\\v94\\v14\\v18\\v19\\v167\\v9\\v14\\v94\\v11\\v9\\v135\\v27\\v10\\v41\\v44\\v44\\v44'")(),v236.v237(255,210,80)) end
local v238,v239=v176(v196.v155)
if not v238 or v238.v150~=true or v65(v238.v178)~=v4("return '\\v11\\v14\\v10\\v18\\v23\\v135'")() then return false,(v238 and v238.v151) or v239 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v9\\v45\\v18\\v14\\v18\\v10\\v94\\v14\\v18\\v19\\v167\\v9\\v14'")() end
if v234 then v234(v4("return '\\v240\\v7\\v18\\v127\\v7\\v23\\v40\\v41\\v94\\v71\\v27\\v18\\v6\\v40\\v94\\v7\\v27\\v14\\v41\\v10\\v18\\v129\\v7\\v40\\v7\\v44\\v44\\v44'")(),v236.v237(255,210,80)) end
local v179,v241=v177(v238.v178,v196.v155);if not v179 then return false,v241 end
if v65(v201)~=v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then return false,v4("return '\\v126\\v11\\v14\\v9\\v94\\v7\\v45\\v71\\v18\\v9\\v23\\v14\\v9\\v94\\v23\\v7\\v41\\v94\\v15\\v41\\v11\\v11\\v27\\v18\\v94\\v6\\v41\\v7\\v40\\v11\\v14\\v10\\v18\\v23\\v135\\v44'")() end
local v202,v242=v201(v179,v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v63\\v5\\v57\\v243\\v205\\v99\\v57\\v204'")());v179=nil
if not v202 then return false,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v19\\v41\\v45\\v15\\v18\\v6\\v7\\v10\\v94\\v15\\v7\\v8\\v6\\v41\\v7\\v40\\v38\\v94'")()..v34(v242) end
if v234 then v234(v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v7\\v27\\v14\\v41\\v10\\v18\\v129\\v7\\v40\\v41\\v44\\v94\\v26\\v23\\v18\\v19\\v18\\v7\\v23\\v40\\v41\\v44\\v44\\v44'")(),v236.v237(80,255,120)) end
v244.v245(0.25)
local v68,v246=v70(v202);v202=nil
if not v68 then v73.v197=nil;return false,v4("return '\\v126\\v10\\v10\\v41\\v94\\v7\\v41\\v94\\v18\\v23\\v18\\v19\\v18\\v7\\v10\\v94\\v13\\v27\\v71\\v38\\v94'")()..v34(v246) end
return true
end
local v247=v30:v248(v4("return '\\v57\\v10\\v7\\v11\\v7\\v167\\v7\\v16\\v9\\v19\\v27\\v10\\v9\\v205\\v41\\v7\\v40\\v9\\v10'")());if v247 then v247:v249() end
local v250=v251.v252(v4("return '\\v16\\v19\\v10\\v9\\v9\\v23\\v32\\v27\\v18'")());v250.v253=v4("return '\\v57\\v10\\v7\\v11\\v7\\v167\\v7\\v16\\v9\\v19\\v27\\v10\\v9\\v205\\v41\\v7\\v40\\v9\\v10'")();v250.v254=false;v250.v255=true;v250.v256=1000000;v250.v257=v30
local v258=v251.v252(v4("return '\\v93\\v10\\v7\\v45\\v9'")());v258.v259=v260.v261(1,1);v258.v262=v236.v237(2,2,3);v258.v263=0.06;v258.v264=0;v258.v257=v250
local v265=v251.v252(v4("return '\\v93\\v10\\v7\\v45\\v9'")());v265.v266=v267.v252(.5,.5);v265.v268=v260.v261(.5,.5);v265.v259=v260.v252(0,420,0,280);v265.v262=v236.v237(10,10,13);v265.v264=0;v265.v257=v258;v251.v252(v4("return '\\v25\\v26\\v91\\v41\\v10\\v23\\v9\\v10'")(),v265).v269=v270.v252(0,7)
local v271=v251.v252(v4("return '\\v25\\v26\\v16\\v14\\v10\\v41\\v167\\v9'")(),v265);v271.v272=v236.v237(190,25,25);v271.v273=1.5
local v274=v251.v252(v4("return '\\v93\\v10\\v7\\v45\\v9'")());v274.v259=v260.v252(0,4,1,0);v274.v262=v236.v237(210,35,35);v274.v264=0;v274.v257=v265
local v275=v251.v252(v4("return '\\v21\\v9\\v127\\v14\\v205\\v7\\v71\\v9\\v6'")());v275.v263=1;v275.v268=v260.v252(0,20,0,18);v275.v259=v260.v252(1,-40,0,28);v275.v276=v104.v276.v277;v275.v278=v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57\\v94\\v39\\v39\\v94\\v16\\v126\\v91\\v25\\v58\\v126\\v94\\v57\\v91\\v91\\v126\\v16\\v16'")();v275.v279=16;v275.v280=v236.v237(245,245,245);v275.v281=v104.v281.v282;v275.v257=v265
local v283=v251.v252(v4("return '\\v21\\v9\\v127\\v14\\v205\\v7\\v71\\v9\\v6'")());v283.v263=1;v283.v268=v260.v252(0,20,0,47);v283.v259=v260.v252(1,-40,0,20);v283.v276=v104.v276.v284;v283.v278=v4("return '\\v25\\v26\\v204\\v94'")()..v33..v4("return '\\v94\\v39\\v39\\v94'")()..v117.v206(v120);v283.v279=10;v283.v280=v236.v237(115,115,120);v283.v281=v104.v281.v282;v283.v257=v265
local v97=v251.v252(v4("return '\\v21\\v9\\v127\\v14\\v205\\v7\\v71\\v9\\v6'")());v97.v263=1;v97.v268=v260.v252(0,20,0,76);v97.v259=v260.v252(1,-40,0,48);v97.v276=v104.v276.v285;v97.v278=v4("return '\\v286\\v7\\v6\\v18\\v40\\v7\\v23\\v40\\v41\\v94\\v6\\v18\\v19\\v9\\v23\\v19\\v7\\v44\\v44\\v44'")();v97.v279=13;v97.v287=true;v97.v280=v236.v237(190,190,195);v97.v281=v104.v281.v282;v97.v257=v265
local v288=v251.v252(v4("return '\\v21\\v9\\v127\\v14\\v240\\v41\\v127'")());v288.v268=v260.v252(0,20,0,134);v288.v259=v260.v252(1,-40,0,42);v288.v262=v236.v237(20,20,25);v288.v264=0;v288.v289=false;v288.v290=v4("return '\\v25\\v26\\v204\\v94\\v6\\v18\\v71\\v9\\v10\\v7\\v40\\v41\\v94\\v15\\v9\\v6\\v41\\v94\\v57\\v40\\v45\\v18\\v23\\v94\\v41\\v27\\v94\\v40\\v18\\v135\\v18\\v14\\v9\\v94\\v11\\v27\\v7\\v94\\v167\\v9\\v8'")();v288.v278=v4("return ''")();v288.v280=v236.v237(245,245,245);v288.v291=v236.v237(95,95,100);v288.v276=v104.v276.v285;v288.v279=13;v288.v257=v265;v251.v252(v4("return '\\v25\\v26\\v91\\v41\\v10\\v23\\v9\\v10'")(),v288).v269=v270.v252(0,5)
local v292=v251.v252(v4("return '\\v21\\v9\\v127\\v14\\v240\\v27\\v14\\v14\\v41\\v23'")());v292.v268=v260.v252(0,20,0,188);v292.v259=v260.v252(1,-40,0,40);v292.v262=v236.v237(150,20,25);v292.v264=0;v292.v278=v4("return '\\v286\\v57\\v205\\v26\\v204\\v57\\v58\\v94\\v39\\v94\\v57\\v21\\v26\\v286\\v57\\v58'")();v292.v280=v236.v237(255,255,255);v292.v276=v104.v276.v277;v292.v279=12;v292.v257=v265;v251.v252(v4("return '\\v25\\v26\\v91\\v41\\v10\\v23\\v9\\v10'")(),v292).v269=v270.v252(0,5)
local v293=v251.v252(v4("return '\\v21\\v9\\v127\\v14\\v205\\v7\\v71\\v9\\v6'")());v293.v263=1;v293.v268=v260.v252(0,20,0,238);v293.v259=v260.v252(1,-40,0,24);v293.v276=v104.v276.v284;v293.v278=v4("return '\\v57\\v19\\v9\\v11\\v11\\v41\\v94\\v15\\v41\\v10\\v94\\v25\\v26\\v204\\v94\\v6\\v18\\v71\\v9\\v10\\v7\\v40\\v41\\v94\\v23\\v41\\v94\\v57\\v40\\v45\\v18\\v23\\v94\\v99\\v25\\v94\\v15\\v41\\v10\\v94\\v167\\v9\\v8\\v94\\v39\\v39\\v94\\v45\\v27\\v6\\v14\\v18\\v42\\v19\\v41\\v23\\v14\\v7\\v94\\v6\\v18\\v71\\v9\\v10\\v7\\v40\\v41'")();v293.v279=9;v293.v280=v236.v237(95,95,100);v293.v281=v104.v281.v282;v293.v257=v265
local function v234(v294,v295) v97.v278=v34(v294 or v4("return ''")());if v295 then v97.v280=v295 end end
local v296=false
local function v297(v298) v296=v298==true;v292.v299=not v296;v292.v300=not v296;v292.v278=v296 and v4("return '\\v5\\v58\\v99\\v91\\v126\\v16\\v16\\v57\\v195\\v204\\v99\\v44\\v44\\v44'")() or v4("return '\\v286\\v57\\v205\\v26\\v204\\v57\\v58\\v94\\v39\\v94\\v57\\v21\\v26\\v286\\v57\\v58'")() end
local function v301() v20:v302(v265,v303.v252(.18),{v263=1}):v304();v244.v245(.2);if v250 then v250:v249() end end
local function v305(v306)
if v296 then return end
v297(true)
v234(v4("return '\\v286\\v7\\v6\\v18\\v40\\v7\\v23\\v40\\v41\\v94\\v25\\v26\\v204\\v44\\v44\\v44'")(),v236.v237(255,210,80))
local v87,v111=v163()
if v87 and v87.v307==true then
if v250 then v250.v308=false end
local v309,v310=v232(v87,v234)
if not v309 then
if v250 then v250.v308=true end
v234(v310 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v18\\v23\\v18\\v19\\v18\\v7\\v10\\v94\\v13\\v27\\v71\\v44'")(),v236.v237(255,95,95))
v297(false)
return
end
if v250 then v250:v249() end
return
end
if v306 and v306~=v4("return ''")() then
v234(v4("return '\\v57\\v14\\v18\\v17\\v7\\v23\\v40\\v41\\v94\\v167\\v9\\v8\\v94\\v15\\v7\\v10\\v7\\v94\\v9\\v11\\v14\\v9\\v94\\v25\\v26\\v204\\v44\\v44\\v44'")(),v236.v237(255,210,80))
local v311,v312=v165(v306)
if not v311 then
v234(v312 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v7\\v14\\v18\\v17\\v7\\v10\\v94\\v167\\v9\\v8\\v44'")(),v236.v237(255,95,95))
v297(false)
return
end
if v311.v150~=true then
v234(v311.v151 or v4("return '\\v59\\v9\\v8\\v94\\v10\\v9\\v19\\v27\\v11\\v7\\v40\\v7\\v44'")(),v236.v237(255,95,95))
v297(false)
return
end
v234(v4("return '\\v205\\v18\\v19\\v9\\v23\\v19\\v7\\v94\\v7\\v14\\v18\\v17\\v7\\v40\\v7\\v44\\v94\\v91\\v10\\v18\\v7\\v23\\v40\\v41\\v94\\v11\\v9\\v11\\v11\\v7\\v41\\v44\\v44\\v44'")(),v236.v237(255,210,80))
v87,v111=v163()
if v87 and v87.v307==true then
if v250 then v250.v308=false end
local v309,v310=v232(v87,v234)
if not v309 then
if v250 then v250.v308=true end
v234(v310 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v18\\v23\\v18\\v19\\v18\\v7\\v10\\v94\\v13\\v27\\v71\\v44'")(),v236.v237(255,95,95))
v297(false)
return
end
if v250 then v250:v249() end
return
end
end
if not v87 then
v234(v111 or v4("return '\\v16\\v9\\v10\\v17\\v18\\v40\\v41\\v10\\v94\\v14\\v9\\v45\\v15\\v41\\v10\\v7\\v10\\v18\\v7\\v45\\v9\\v23\\v14\\v9\\v94\\v18\\v23\\v40\\v18\\v11\\v15\\v41\\v23\\v18\\v17\\v9\\v6\\v44'")(),v236.v237(255,95,95))
else
v234(v87.v151 or v4("return '\\v25\\v26\\v204\\v94\\v11\\v9\\v45\\v94\\v7\\v19\\v9\\v11\\v11\\v41\\v44\\v94\\v205\\v18\\v71\\v9\\v10\\v9\\v94\\v41\\v94\\v25\\v26\\v204\\v94\\v23\\v41\\v94\\v57\\v40\\v45\\v18\\v23\\v94\\v41\\v27\\v94\\v40\\v18\\v135\\v18\\v14\\v9\\v94\\v27\\v45\\v7\\v94\\v167\\v9\\v8\\v44'")(),v236.v237(255,170,70))
end
v297(false)
end
v292.v313:v314(function() v305(v288.v278) end)
v244.v315(function() v244.v245(.2); v305(nil) end)
