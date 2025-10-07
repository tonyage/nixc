{ user, config, ... }:
let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";
  font_size_small = "11.0";
  font_size = "13.0";
  font = "JetBrainsMono Nerd Font";
  bold_font = "JetBrainsMono Nerd Font-Bold";
in {
#   "${config.users.users.${user}.home}/Library/Developer/Xcode/UserData/FontAndColorThemes/Dusk (Dark).xccolortheme".text = ''
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
# 	<key>DVTConsoleDebuggerInputTextColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTConsoleDebuggerInputTextFont</key>
# 	<string>JetBrainsMonoNLNF-Regular - 11.0</string>
# 	<key>DVTConsoleDebuggerOutputTextColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTConsoleDebuggerOutputTextFont</key>
# 	<string>JetBrainsMonoNLNF-Regular - 11.0</string>
# 	<key>DVTConsoleDebuggerPromptTextColor</key>
# 	<string>0.433396 0.820067 0.39569 1</string>
# 	<key>DVTConsoleDebuggerPromptTextFont</key>
# 	<string>JetBrainsMonoNLNF-Regular - 11.0</string>
# 	<key>DVTConsoleExectuableInputTextColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTConsoleExectuableInputTextFont</key>
# 	<string>JetBrainsMonoNLNF-Regular - 11.0</string>
# 	<key>DVTConsoleExectuableOutputTextColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTConsoleExectuableOutputTextFont</key>
# 	<string>JetBrainsMonoNLNF-Regular - 11.0</string>
# 	<key>DVTConsoleTextBackgroundColor</key>
# 	<string>0.068528 0.068528 0.068528 1</string>
# 	<key>DVTConsoleTextInsertionPointColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTConsoleTextSelectionColor</key>
# 	<string>0.133333 0.133333 0.133333 1</string>
# 	<key>DVTCursor</key>
# 	<integer>2</integer>
# 	<key>DVTFontAndColorVersion</key>
# 	<integer>1</integer>
# 	<key>DVTFontSizeModifier</key>
# 	<integer>-1</integer>
# 	<key>DVTLineSpacing</key>
# 	<real>1.2000000476837158</real>
# 	<key>DVTMarkupTextBackgroundColor</key>
# 	<string>0.18856 0.195 0.22444 1</string>
# 	<key>DVTMarkupTextBorderColor</key>
# 	<string>0.253475 0.2594 0.286485 1</string>
# 	<key>DVTMarkupTextCodeFont</key>
# 	<string>SFMono-Regular - 9.0</string>
# 	<key>DVTMarkupTextEmphasisColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTMarkupTextEmphasisFont</key>
# 	<string>.SFNS-RegularItalic - 9.0</string>
# 	<key>DVTMarkupTextInlineCodeColor</key>
# 	<string>1 1 1 0.7</string>
# 	<key>DVTMarkupTextLinkColor</key>
# 	<string>0.33 0.247124 0.894195 1</string>
# 	<key>DVTMarkupTextLinkFont</key>
# 	<string>.SFNS-Regular - 9.0</string>
# 	<key>DVTMarkupTextNormalColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTMarkupTextNormalFont</key>
# 	<string>.SFNS-Regular - 9.0</string>
# 	<key>DVTMarkupTextOtherHeadingColor</key>
# 	<string>1 1 1 0.5</string>
# 	<key>DVTMarkupTextOtherHeadingFont</key>
# 	<string>.SFNS-Regular - 12.6</string>
# 	<key>DVTMarkupTextPrimaryHeadingColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTMarkupTextPrimaryHeadingFont</key>
# 	<string>.SFNS-Regular - 21.6</string>
# 	<key>DVTMarkupTextSecondaryHeadingColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTMarkupTextSecondaryHeadingFont</key>
# 	<string>.SFNS-Regular - 16.2</string>
# 	<key>DVTMarkupTextStrongColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTMarkupTextStrongFont</key>
# 	<string>.SFNS-Bold - 9.0</string>
# 	<key>DVTScrollbarMarkerAnalyzerColor</key>
# 	<string>0.403922 0.372549 1 1</string>
# 	<key>DVTScrollbarMarkerBreakpointColor</key>
# 	<string>0.290196 0.290196 0.968627 1</string>
# 	<key>DVTScrollbarMarkerDiffColor</key>
# 	<string>0.556863 0.556863 0.556863 1</string>
# 	<key>DVTScrollbarMarkerDiffConflictColor</key>
# 	<string>0.968627 0.290196 0.290196 1</string>
# 	<key>DVTScrollbarMarkerErrorColor</key>
# 	<string>0.968627 0.290196 0.290196 1</string>
# 	<key>DVTScrollbarMarkerRuntimeIssueColor</key>
# 	<string>0.643137 0.509804 1 1</string>
# 	<key>DVTScrollbarMarkerWarningColor</key>
# 	<string>0.937255 0.717647 0.34902 1</string>
# 	<key>DVTSourceTextBackground</key>
# 	<string>0.0685091 0.0685091 0.0685091 1</string>
# 	<key>DVTSourceTextBlockDimBackgroundColor</key>
# 	<string>0.5 0.5 0.5 1</string>
# 	<key>DVTSourceTextCurrentLineHighlightColor</key>
# 	<string>0.133333 0.133333 0.133333 1</string>
# 	<key>DVTSourceTextInsertionPointColor</key>
# 	<string>1 1 1 1</string>
# 	<key>DVTSourceTextInvisiblesColor</key>
# 	<string>0.258298 0.300954 0.355207 1</string>
# 	<key>DVTSourceTextSelectionColor</key>
# 	<string>0.133333 0.133333 0.133333 1</string>
# 	<key>DVTSourceTextSyntaxColors</key>
# 	<dict>
# 		<key>xcode.syntax.attribute</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.character</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.comment</key>
# 		<string>0.223529 0.223529 0.223529 1</string>
# 		<key>xcode.syntax.comment.doc</key>
# 		<string>0.537255 0.792157 0.470588 1</string>
# 		<key>xcode.syntax.comment.doc.keyword</key>
# 		<string>0.537255 0.792157 0.470588 1</string>
# 		<key>xcode.syntax.declaration.other</key>
# 		<string>0.937255 0.34902 0.435294 1</string>
# 		<key>xcode.syntax.declaration.type</key>
# 		<string>0.937255 0.792157 0.521569 1</string>
# 		<key>xcode.syntax.identifier.class</key>
# 		<string>0.435294 0.811765 0.858824 1</string>
# 		<key>xcode.syntax.identifier.class.system</key>
# 		<string>0.937255 0.792157 0.521569 1</string>
# 		<key>xcode.syntax.identifier.constant</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.identifier.constant.system</key>
# 		<string>0.632318 0.402193 0.901151 1</string>
# 		<key>xcode.syntax.identifier.function</key>
# 		<string>0.937255 0.34902 0.435294 1</string>
# 		<key>xcode.syntax.identifier.function.system</key>
# 		<string>0.419608 0.72549 0.976471 1</string>
# 		<key>xcode.syntax.identifier.macro</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.identifier.macro.system</key>
# 		<string>0.937255 0.34902 0.435294 1</string>
# 		<key>xcode.syntax.identifier.type</key>
# 		<string>0.937255 0.792157 0.521569 1</string>
# 		<key>xcode.syntax.identifier.type.system</key>
# 		<string>0.937255 0.792157 0.521569 1</string>
# 		<key>xcode.syntax.identifier.variable</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.identifier.variable.system</key>
# 		<string>0.937255 0.34902 0.435294 1</string>
# 		<key>xcode.syntax.keyword</key>
# 		<string>0.835294 0.372549 0.870588 1</string>
# 		<key>xcode.syntax.mark</key>
# 		<string>0.635294 0.894118 0.454902 1</string>
# 		<key>xcode.syntax.markup.code</key>
# 		<string>0.665 0.052 0.569 1</string>
# 		<key>xcode.syntax.number</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.plain</key>
# 		<string>0.670588 0.698039 0.74902 1</string>
# 		<key>xcode.syntax.preprocessor</key>
# 		<string>0.937255 0.792157 0.521569 1</string>
# 		<key>xcode.syntax.regex</key>
# 		<string>0.435294 0.811765 0.858824 1</string>
# 		<key>xcode.syntax.regex.capturename</key>
# 		<string>0.435294 0.811765 0.858824 1</string>
# 		<key>xcode.syntax.regex.charname</key>
# 		<string>0.632318 0.402193 0.901151 1</string>
# 		<key>xcode.syntax.regex.number</key>
# 		<string>0.956863 0.623529 0.415686 1</string>
# 		<key>xcode.syntax.regex.other</key>
# 		<string>0.670588 0.698039 0.74902 1</string>
# 		<key>xcode.syntax.string</key>
# 		<string>0.576471 0.831373 0.509804 1</string>
# 		<key>xcode.syntax.url</key>
# 		<string>0.435294 0.811765 0.858824 1</string>
# 	</dict>
# 	<key>DVTSourceTextSyntaxFonts</key>
# 	<dict>
# 		<key>xcode.syntax.attribute</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.character</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.comment</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.comment.doc</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.comment.doc.keyword</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.declaration.other</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.declaration.type</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.class</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.class.system</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.constant</key>
# 		<string>JetBrainsMonoNF-Bold - 10.0</string>
# 		<key>xcode.syntax.identifier.constant.system</key>
# 		<string>JetBrainsMonoNF-Bold - 10.0</string>
# 		<key>xcode.syntax.identifier.function</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.function.system</key>
# 		<string>JetBrainsMonoNF-Bold - 10.0</string>
# 		<key>xcode.syntax.identifier.macro</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.macro.system</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.type</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.type.system</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.identifier.variable</key>
# 		<string>JetBrainsMonoNF-LightItalic - 10.0</string>
# 		<key>xcode.syntax.identifier.variable.system</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.keyword</key>
# 		<string>JetBrainsMonoNF-BoldItalic - 10.0</string>
# 		<key>xcode.syntax.mark</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.markup.code</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.number</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.plain</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.preprocessor</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.regex</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.regex.capturename</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.regex.charname</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.regex.number</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.regex.other</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.string</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 		<key>xcode.syntax.url</key>
# 		<string>JetBrainsMonoNF-Regular - 10.0</string>
# 	</dict>
# </dict>
# </plist>
#   '';
}
