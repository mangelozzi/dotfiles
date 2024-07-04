local M = {}

function M.get_groups(p)
    return {
        -- VIML

        -- vimTodo        xxx links to Todo
        -- vimCommand     xxx links to Statement
        -- vimOnlyCommand xxx cleared
        -- vimStdPlugin   xxx cleared
        -- vimOnlyOption  xxx cleared
        -- vimTermOption  xxx cleared
        -- vimErrSetting  xxx links to vimError
        -- vimGroup       xxx links to Type
        -- vimHLGroup     xxx links to vimGroup
        -- vimOnlyHLGroup xxx cleared
        -- vimGlobal      xxx cleared
        -- vimSubst       xxx links to vimCommand
        -- vimComment     xxx links to Comment
        -- vimNumber      xxx links to Number
        -- vimAddress     xxx links to vimMark
        -- vimAutoCmd     xxx links to vimCommand
        -- vimEcho        xxx cleared
        -- vimIsCommand   xxx cleared
        -- vimExtCmd      xxx cleared
        -- vimFilter      xxx cleared
        -- vimLet         xxx links to vimCommand
        -- vimMap         xxx links to vimCommand
        -- vimMark        xxx links to Number
        -- vimSet         xxx cleared
        -- vimSyntax      xxx links to vimCommand
        -- vimUserCmd     xxx cleared
        -- vimCmdSep      xxx cleared
        -- vimVar         xxx links to Identifier
        vimVar = { fg = p.nb2 },
        -- vimFBVar       xxx links to vimVar
        -- vimInsert      xxx links to vimString
        -- vimBehaveModel xxx links to vimBehave
        -- vimBehaveError xxx links to vimError
        -- vimBehave      xxx links to vimCommand
        -- vimFTCmd       xxx links to vimCommand
        -- vimFTOption    xxx links to vimSynType
        -- vimFTError     xxx links to vimError
        -- vimFiletype    xxx cleared
        -- vimAugroup     xxx cleared
        -- vimExecute     xxx cleared
        -- vimNotFunc     xxx links to vimCommand
        -- vimFuncName    xxx links to Function
        vimFuncName = { fg = p.main3 },
        -- vimFunction    xxx cleared
        vimFunction = { fg = p.main2 },
        -- vimFunctionError xxx links to vimError
        -- vimLineComment xxx links to vimComment
        -- vimSpecFile    xxx links to Identifier
        -- vimOper        xxx links to Operator
        -- vimOperParen   xxx cleared
        -- vimString      xxx links to String
        -- vimRegister    xxx links to SpecialChar
        -- vimCmplxRepeat xxx links to SpecialChar
        -- vimRegion      xxx cleared
        -- vimSynLine     xxx cleared
        -- vimNotation    xxx links to Special
        -- vimCtrlChar    xxx links to SpecialChar
        -- vimFuncVar     xxx links to Identifier
        -- vimContinue    xxx links to Special
        -- vimSetEqual    xxx cleared
        -- vimOption      xxx links to PreProc
        -- vimAugroupKey  xxx links to vimCommand
        -- vimAugroupError xxx links to vimError
        -- vimEnvvar      xxx links to PreProc
        -- vimFunc        xxx links to vimError
        -- vimParenSep    xxx links to Delimiter
        -- vimSep         xxx links to Delimiter
        -- vimOperError   xxx links to Error
        -- vimFuncKey     xxx links to vimCommand
        -- vimFuncSID     xxx links to Special
        -- vimAbb         xxx links to vimCommand
        -- vimEchoHL      xxx links to vimCommand
        -- vimHighlight   xxx links to vimCommand
        -- vimNorm        xxx links to vimCommand
        -- vimSearch      xxx links to vimString
        -- vimUnmap       xxx links to vimMap
        -- vimUserCommand xxx links to vimCommand
        -- vimFuncBody    xxx cleared
        -- vimFuncBlank   xxx cleared
        -- vimPattern     xxx links to Type
        -- vimSpecFileMod xxx links to vimSpecFile
        -- vimEscapeBrace xxx cleared
        -- vimSetString   xxx links to vimString
        -- vimSubstRep    xxx cleared
        -- vimSubstRange  xxx cleared
        -- vimUserAttrb   xxx links to vimSpecial
        -- vimUserAttrbError xxx links to Error
        -- vimUserAttrbKey xxx links to vimOption
        -- vimUserAttrbCmplt xxx links to vimSpecial
        -- vimUserCmdError xxx links to Error
        -- vimUserAttrbCmpltFunc xxx links to Special
        -- vimCommentString xxx links to vimString
        -- vimPatSepErr   xxx links to vimError
        -- vimPatSep      xxx links to SpecialChar
        -- vimPatSepZ     xxx links to vimPatSep
        -- vimPatSepZone  xxx links to vimString
        -- vimPatSepR     xxx links to vimPatSep
        -- vimPatRegion   xxx cleared
        -- vimNotPatSep   xxx links to vimString
        -- vimStringEnd   xxx links to vimString
        -- vimStringCont  xxx links to vimString
        -- vimSubstTwoBS  xxx links to vimString
        -- vimSubstSubstr xxx links to SpecialChar
        -- vimCollection  xxx cleared
        -- vimSubstPat    xxx cleared
        -- vimSubst1      xxx links to vimSubst
        -- vimSubst2      xxx cleared
        -- vimSubstDelim  xxx links to Delimiter
        -- vimSubstRep4   xxx cleared
        -- vimSubstFlagErr xxx links to vimError
        -- vimCollClass   xxx cleared
        -- vimCollClassErr xxx links to vimError
        -- vimSubstFlags  xxx links to Special
        -- vimMarkNumber  xxx links to vimNumber
        -- vimPlainMark   xxx links to vimMark
        -- vimRange       xxx cleared
        -- vimPlainRegister xxx links to vimRegister
        -- vimSetMod      xxx links to vimOption
        -- vimSetSep      xxx links to Statement
        -- vimMapMod      xxx links to vimBracket
        -- vimMapLhs      xxx cleared
        -- vimAutoEvent   xxx links to Type
        -- vimAutoCmdSpace xxx cleared
        -- vimAutoEventList xxx cleared
        -- vimAutoCmdSfxList xxx cleared
        -- vimEchoHLNone  xxx links to vimGroup
        -- vimMapBang     xxx links to vimCommand
        -- vimMapRhs      xxx cleared
        -- vimMapModKey   xxx links to vimFuncSID
        -- vimMapModErr   xxx links to vimError
        -- vimMapRhsExtend xxx cleared
        -- vimMenuBang    xxx cleared
        -- vimMenuPriority xxx cleared
        -- vimMenuName    xxx links to PreProc
        -- vimMenuMod     xxx links to vimMapMod
        -- vimMenuNameMore xxx links to vimMenuName
        -- vimMenuMap     xxx cleared
        -- vimMenuRhs     xxx cleared
        -- vimBracket     xxx links to Delimiter
        -- vimUserFunc    xxx links to Normal
        -- vimElseIfErr   xxx links to Error
        -- vimBufnrWarn   xxx links to vimWarn
        -- vimNormCmds    xxx cleared
        -- vimGroupSpecial xxx links to Special
        -- vimGroupList   xxx cleared
        -- vimSynError    xxx links to Error
        -- vimSynContains xxx links to vimSynOption
        -- vimSynKeyContainedin xxx links to vimSynContains
        -- vimSynNextgroup xxx links to vimSynOption
        -- vimSynType     xxx links to vimSpecial
        -- vimAuSyntax    xxx cleared
        -- vimSynCase     xxx links to Type
        -- vimSynCaseError xxx links to vimError
        -- vimClusterName xxx cleared
        -- vimGroupName   xxx links to vimGroup
        -- vimGroupAdd    xxx links to vimSynOption
        -- vimGroupRem    xxx links to vimSynOption
        -- vimIskList     xxx cleared
        -- vimIskSep      xxx links to Delimiter
        -- vimSynKeyOpt   xxx links to vimSynOption
        -- vimSynKeyRegion xxx cleared
        -- vimMtchComment xxx links to vimComment
        -- vimSynMtchOpt  xxx links to vimSynOption
        -- vimSynRegPat   xxx links to vimString
        -- vimSynMatchRegion xxx cleared
        -- vimSynMtchCchar xxx cleared
        -- vimSynMtchGroup xxx cleared
        -- vimSynPatRange xxx links to vimString
        -- vimSynNotPatRange xxx links to vimSynRegPat
        -- vimSynRegOpt   xxx links to vimSynOption
        -- vimSynReg      xxx links to Type
        -- vimSynMtchGrp  xxx links to vimSynOption
        -- vimSynRegion   xxx cleared
        -- vimSynPatMod   xxx cleared
        -- vimSyncC       xxx links to Type
        -- vimSyncLines   xxx cleared
        -- vimSyncMatch   xxx cleared
        -- vimSyncError   xxx links to Error
        -- vimSyncLinebreak xxx cleared
        -- vimSyncLinecont xxx cleared
        -- vimSyncRegion  xxx cleared
        -- vimSyncGroupName xxx links to vimGroupName
        -- vimSyncKey     xxx links to Type
        -- vimSyncGroup   xxx links to vimGroupName
        -- vimSyncNone    xxx links to Type
        -- vimHiLink      xxx cleared
        -- vimHiClear     xxx links to vimHighlight
        -- vimHiKeyList   xxx cleared
        -- vimHiCtermError xxx links to vimError
        -- vimHiBang      xxx cleared
        -- vimHiGroup     xxx links to vimGroupName
        vimHiGroup = { fg = p.main3 },
        -- vimHiAttrib    xxx links to PreProc
        -- vimFgBgAttrib  xxx links to vimHiAttrib
        -- vimHiAttribList xxx links to vimError
        -- vimHiCtermColor xxx cleared
        -- vimHiFontname  xxx cleared
        -- vimHiGuiFontname xxx cleared
        -- vimHiGuiRgb    xxx links to vimNumber
        vimHiGuiRgb = { fg = p.constant },
        -- vimHiBlend     xxx links to vimHiTerm
        -- vimHiTerm      xxx links to Type
        -- vimHiCTerm     xxx links to vimHiTerm
        -- vimHiStartStop xxx links to vimHiTerm
        -- vimHiCtermFgBg xxx links to vimHiTerm
        -- vimHiGui       xxx links to vimHiTerm
        -- vimHiGuiFont   xxx links to vimHiTerm
        -- vimHiGuiFgBg   xxx links to vimHiTerm
        vimHiGuiFgBg = { fg = p.nb2 },
        -- vimHiKeyError  xxx links to vimError
        -- vimHiTermcap   xxx cleared
        -- vimHiNmbr      xxx links to Number
        -- vimCommentTitle xxx links to PreProc
        -- vimCommentTitleLeader xxx cleared
        -- vimSearchDelim xxx links to Statement
        -- vimEmbedError  xxx links to Normal
        -- vimAugroupSyncA xxx cleared
        -- vimError       xxx links to Error
        -- vimKeyCodeError xxx links to vimError
        -- vimWarn        xxx links to WarningMsg
        -- vimAuHighlight xxx links to vimHighlight
        -- vimAutoCmdOpt  xxx links to vimOption
        -- vimAutoSet     xxx links to vimCommand
        -- vimCondHL      xxx links to vimCommand
        -- vimElseif      xxx links to vimCondHL
        -- vimFold        xxx links to Folded
        -- vimSynOption   xxx links to Special
        -- vimHLMod       xxx links to PreProc
        -- vimKeyCode     xxx links to vimSpecFile
        -- vimKeyword     xxx links to Statement
        -- vimScriptDelim xxx links to Comment
        -- vimSpecial     xxx links to Type
        -- vimStatement   xxx links to Statement

        -- HTML

        ['@tag.html'] = { fg = p.main2 },
        ['@tag.delimiter.html'] = { fg = p.main1 },
        ['@tag.attribute.html'] = { fg = p.nb1 },
        ['@character.special.html'] = { fg = p.purple },
        ['@string.html'] = { fg = p.constant },

        -- htmlValue = { fg = p.number },
        -- htmlEndTag = { fg = p.noisell },
        -- htmlArg = { fg = p.nb1 },
        -- htmlEvent = { fg = p.alt },
        -- htmlTag = { fg = p.main2 },
        -- htmlTagName = { fg = p.main2 },
        -- htmlSpecialTagName = { fg = p.main1 },
        -- htmlComment = { fg = p.commentl },
        -- htmlEventDQ = { fg = p.alth },
        -- htmlStyleArg = { fg = p.fuchsia },

        -- CSS

        ['@type.css']         = { fg = p.purple, bg = p.purple_bg },    -- `hide` { - I.e. a class name
        ['@attribute.css']    = { fg = p.nb1, bg = "none", nocombine = true },     -- :`active` 
        ['@property.css']     = { fg = p.yellow },  -- `align-items`
        ['@string.css']       = { fg = p.aqua },    -- 16`px`
        ['@number.css']       = { fg = p.green },   -- `16`px
        ['@number.float.css'] = { fg = p.green },   -- `1.125`
        ['@function.css']     = { fg = p.aqua },    -- `var`()
        ['@punctuation.delimiter.css'] = { fg = '#f0f0f0', bold=true },    -- `var`()

        cssTagName = { fg = p.main1, bg = p.main1_bg },
        cssAttributeSelector = { fg = p.speciall, bg = p.special_bg },
        cssClassName = { fg = p.purple, bg = p.purple_bg },
        cssClassNameDot = { link = 'cssClassName' },
        cssIdentifier = { fg = p.main2, bg = p.main2_bg },
        cssUnitDecorators = { fg = p.numberl },
        cssColor = { fg = p.constanth },
        cssBraces = { fg = p.alth },
        cssVendor = { fg = p.main3 },
        cssProp = { fg = p.nb2 },

        -- PYTHON

        -- pythonAsync    xxx links to Statement
        -- pythonAttribute xxx cleared
        -- pythonBuiltin  xxx links to Function
        pythonBuiltin = { fg = p.pink },
        -- pythonComment  xxx links to Comment
        -- pythonConditional xxx links to Conditional
        -- pythonDecorator xxx links to Define
        pythonDecorator = { fg = p.pinkl },
        -- pythonDecoratorName xxx links to Function
        pythonDecoratorname = { fg = p.pink },
        -- pythonDoctest  xxx links to Special
        -- pythonDoctestValue xxx links to Define
        -- pythonEscape   xxx links to Special
        -- pythonException xxx links to Exception
        -- pythonExceptions xxx links to Structure
        -- pythonFunction xxx links to Function
        -- pythonInclude  xxx links to Include
        -- pythonMatrixMultiply xxx cleared
        -- pythonOperator xxx links to Operator
        -- pythonQuotes   xxx links to String
        pythonQuotes = { fg = p.stringl },
        -- pythonRawString xxx links to String
        pythonRawstring = { fg = p.number },
        -- pythonRepeat   xxx links to Repeat
        -- pythonSpaceError xxx cleared
        pythonSpaceerror = { fg = p.white, bg = p.isoerrorred },
        -- pythonStatement xxx links to Statement
        -- pythonString   xxx links to String
        -- pythonSync     xxx cleared
        -- pythonTodo     xxx links to Todo
        -- pythonTripleQuotes xxx links to pythonQuotes

        -- DJANGO

        -- djangoError    xxx links to Error
        -- djangoStatement xxx links to Statement
        djangoStatement = { fg = p.purpleh },
        -- djangoFilter   xxx links to Identifier
        djangoFilter = { fg = p.pink, bg = p.alt_bg },
        -- djangoTodo     xxx links to Todo
        -- djangoArgument xxx links to Constant
        djangoArgument = { fg = p.purplel, bg = p.alt_bg },
        -- djangoTagError xxx links to Error
        -- djangoVarError xxx links to Error
        -- djangoTagBlock xxx links to PreProc
        djangoTagBlock = { fg = p.normalh, bg = p.alt_bg },
        -- djangoVarBlock xxx links to PreProc
        djangoVarBlock = { fg = p.pinkh, bg = p.alt_bg },
        -- djangoComment  xxx links to Comment
        djangoComment = { fg = p.commentl, bg = p.alt_bg },
        -- djangoComBlock xxx links to Comment
        djangoComBlock = { fg = p.comment, bg = p.alt_bg },

        -- JS

        -- jsNoise        xxx links to Noise
        -- jsObjectProp   xxx cleared
        -- jsFuncCall     xxx links to Function
        jsfunccall = { fg = p.nb3 },
        -- jsPrototype    xxx links to Special
        -- jsTaggedTemplate xxx links to StorageClass
        -- jsDot          xxx links to Noise
        -- jsParensError  xxx links to Error
        -- jsStorageClass xxx links to StorageClass
        -- jsDestructuringBlock xxx cleared
        -- jsDestructuringArray xxx cleared
        -- jsVariableDef  xxx cleared
        -- jsFlowDefinition xxx cleared
        -- jsOperatorKeyword xxx links to jsOperator
        -- jsOperator     xxx links to Operator
        -- jsBooleanTrue  xxx links to Boolean
        -- jsBooleanFalse xxx links to Boolean
        -- jsImport       xxx links to Include
        -- jsModuleAsterisk xxx links to Noise
        -- jsModuleKeyword xxx cleared
        -- jsModuleGroup  xxx cleared
        -- jsFlowImportType xxx cleared
        -- jsExport       xxx links to Include
        -- jsExportDefault xxx links to StorageClass
        -- jsFlowTypeStatement xxx cleared
        -- jsModuleAs     xxx links to Include
        -- jsFrom         xxx links to Include
        -- jsModuleComma  xxx links to jsNoise
        -- jsExportDefaultGroup xxx links to jsExportDefault
        -- jsString       xxx links to String
        -- jsFlowTypeKeyword xxx cleared
        -- jsSpecial      xxx links to Special
        -- jsTemplateExpression xxx cleared
        -- jsTemplateString xxx links to String
        -- jsNumber       xxx links to Number
        -- jsFloat        xxx links to Float
        -- jsTemplateBraces xxx links to Noise
        -- jsRegexpCharClass xxx links to Character
        -- jsRegexpBoundary xxx links to SpecialChar
        -- jsRegexpBackRef xxx links to SpecialChar
        -- jsRegexpQuantifier xxx links to SpecialChar
        -- jsRegexpOr     xxx links to Conditional
        -- jsRegexpMod    xxx links to SpecialChar
        -- jsRegexpGroup  xxx links to jsRegexpString
        -- jsRegexpString xxx links to String
        -- jsObjectSeparator xxx links to Noise
        -- jsObjectShorthandProp xxx links to jsObjectKey
        -- jsFunctionKey  xxx cleared
        -- jsObjectValue  xxx cleared
        -- jsObjectKey    xxx cleared
        -- jsObjectKeyString xxx links to String
        -- jsBrackets     xxx links to Noise
        -- jsFuncArgs     xxx cleared
        -- jsObjectKeyComputed xxx cleared
        -- jsObjectColon  xxx links to jsNoise
        -- jsObjectFuncName xxx links to Function
        -- jsObjectMethodType xxx links to Type
        -- jsObjectStringKey xxx links to String
        -- jsNull         xxx links to Type
        -- jsReturn       xxx links to Statement
        -- jsUndefined    xxx links to Type
        -- jsNan          xxx links to Number
        -- jsThis         xxx links to Special
        -- jsSuper        xxx links to Constant
        -- jsBlock        xxx cleared
        -- jsBlockLabel   xxx links to Identifier
        -- jsBlockLabelKey xxx links to jsBlockLabel
        -- jsStatement    xxx links to Statement
        -- jsConditional  xxx links to Conditional
        -- jsParenIfElse  xxx cleared
        -- jsCommentIfElse xxx links to jsComment
        -- jsIfElseBlock  xxx cleared
        -- jsParenSwitch  xxx cleared
        -- jsRepeat       xxx links to Repeat
        -- jsParenRepeat  xxx cleared
        -- jsForAwait     xxx links to Keyword
        -- jsDo           xxx links to Repeat
        -- jsRepeatBlock  xxx cleared
        -- jsLabel        xxx links to Label
        -- jsSwitchColon  xxx links to Noise
        -- jsSwitchCase   xxx cleared
        -- jsTry          xxx links to Exception
        -- jsTryCatchBlock xxx cleared
        -- jsFinally      xxx links to Exception
        -- jsFinallyBlock xxx cleared
        -- jsCatch        xxx links to Exception
        -- jsParenCatch   xxx cleared
        -- jsException    xxx links to Exception
        -- jsAsyncKeyword xxx links to Keyword
        -- jsSwitchBlock  xxx cleared
        -- jsGlobalObjects xxx links to Constant
        jsGlobalObjects = { fg = p.purple },
        -- jsGlobalNodeObjects xxx links to Constant
        -- jsExceptions   xxx links to Constant
        -- jsBuiltins     xxx links to Constant
        -- jsFutureKeys   xxx cleared
        -- jsDomErrNo     xxx links to Constant
        -- jsDomNodeConsts xxx links to Constant
        -- jsHtmlEvents   xxx links to Special
        -- jsSpreadExpression xxx cleared
        -- jsBracket      xxx cleared
        -- jsParens       xxx links to Noise
        -- jsParen        xxx cleared
        -- jsParensDecorator xxx links to jsParens
        -- jsParenDecorator xxx cleared
        -- jsParensIfElse xxx links to jsParens
        jsParensIfElse = { fg = p.nb1 },
        -- jsParensRepeat xxx links to jsParens
        jsParensRepeat = { fg = p.nb2 },
        -- jsCommentRepeat xxx links to jsComment
        -- jsParensSwitch xxx links to jsParens
        jsParensSwitch = { fg = p.nb2 },
        -- jsParensCatch  xxx links to jsParens
        -- jsFuncParens   xxx links to Noise
        jsFuncParens = { fg = p.main2 },
        -- jsFuncArgCommas xxx cleared
        -- jsComment      xxx links to Comment
        -- jsFuncArgExpression xxx cleared
        -- jsRestExpression xxx links to jsFuncArgs
        -- jsFlowArgumentDef xxx cleared
        -- jsCommentFunction xxx links to jsComment
        -- jsFuncBlock    xxx cleared
        -- jsFlowReturn   xxx cleared
        -- jsClassBraces  xxx links to Noise
        jsClassBraces = { fg = p.brown },
        -- jsClassFuncName xxx links to jsFuncName
        -- jsClassMethodType xxx links to Type
        -- jsArrowFunction xxx links to Type
        -- jsArrowFuncArgs xxx links to jsFuncArgs
        -- jsGenerator    xxx links to jsFunction
        -- jsDecorator    xxx links to Special
        -- jsClassProperty xxx links to jsObjectKey
        -- jsClassPropertyComputed xxx cleared
        -- jsClassStringKey xxx links to String
        -- jsClassBlock   xxx cleared
        -- jsFuncBraces   xxx links to Noise
        jsFuncBraces = { fg = p.main2 },
        -- jsIfElseBraces xxx links to Noise
        jsIfElseBraces = { fg = p.nb1 },
        -- jsTryCatchBraces xxx links to Noise
        jsTryCatchBraces = { fg = p.main1 },
        -- jsFinallyBraces xxx links to Noise
        jsFinallyBraces = { fg = p.main1 },
        -- jsSwitchBraces xxx links to Noise
        jsSwitchBraces = { fg = p.nb2 },
        -- jsRepeatBraces xxx links to Noise
        jsRepeatBraces = { fg = p.nb2 },
        -- jsDestructuringBraces xxx links to Noise
        -- jsDestructuringProperty xxx links to jsFuncArgs
        -- jsDestructuringAssignment xxx links to jsObjectKey
        -- jsDestructuringNoise xxx links to Noise
        -- jsDestructuringPropertyComputed xxx cleared
        -- jsDestructuringPropertyValue xxx cleared
        -- jsObjectBraces xxx links to Noise
        jsObjectBraces = { fg = p.alt1 },
        -- jsObject       xxx cleared
        -- jsBraces       xxx links to Noise
        -- jsModuleBraces xxx links to Noise
        -- jsSpreadOperator xxx links to Operator
        -- jsRestOperator xxx links to Operator
        -- jsTernaryIfOperator xxx links to Operator
        -- jsTernaryIf    xxx cleared
        -- jsFuncName     xxx links to Function
        -- jsFlowFunctionGroup xxx cleared
        -- jsFuncArgOperator xxx links to jsFuncArgs
        -- jsArguments    xxx links to Special
        -- jsFunction     xxx links to Type
        jsfunction  = { fg = p.main1 },
        -- jsClassKeyword xxx links to Keyword
        jsClassKeyword = { fg = p.main1 },
        -- jsExtendsKeyword xxx links to Keyword
        -- jsClassNoise   xxx links to Noise
        -- jsFlowClassFunctionGroup xxx cleared
        -- jsFlowClassGroup xxx cleared
        -- jsCommentClass xxx links to jsComment
        -- jsClassDefinition xxx links to jsFuncName
        jsClassDefinition = { fg = p.main2 },
        -- jsClassValue   xxx cleared
        -- jsFlowClassDef xxx cleared
        -- jsDestructuringValue xxx cleared
        -- jsDestructuringValueAssignment xxx cleared
        -- jsCommentTodo  xxx links to Todo
        -- jsEnvComment   xxx links to PreProc
        -- jsDecoratorFunction xxx links to Function
        -- jsCharacter    xxx links to Character
        -- jsBranch       xxx links to Conditional
        -- jsError        xxx links to Error
        -- jsOf           xxx links to Operator
        -- jsDomElemAttrs xxx links to Label
        -- jsDomElemFuncs xxx links to PreProc
        -- jsHtmlElemAttrs xxx links to Label
        -- jsHtmlElemFuncs xxx links to PreProc
        -- jsCssStyles    xxx links to Label

        -- JSON

        jsonBraces = { fg = p.alth },
    }
end

return M
