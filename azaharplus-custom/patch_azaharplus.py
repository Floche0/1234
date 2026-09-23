#!/usr/bin/env python3
from pathlib import Path
import sys

root = Path(sys.argv[1] if len(sys.argv) > 1 else "AzaharPlus")
adapter = root / "src/android/app/src/main/java/org/citra/citra_emu/adapters/GameAdapter.kt"
layout = root / "src/android/app/src/main/res/layout/dialog_about_game.xml"
gradle = root / "src/android/app/build.gradle.kts"

text = adapter.read_text(encoding="utf-8")

needle = '''    private val preferences: SharedPreferences
        get() = PreferenceManager.getDefaultSharedPreferences(CitraApplication.appContext)
'''
insert = needle + '''
    private fun customTitleKey(game: Game): String =
        if (game.titleId != 0L) {
            "custom_game_title_${String.format("%016X", game.titleId)}"
        } else {
            "custom_game_title_path_${game.path.hashCode()}"
        }

    private fun displayTitle(game: Game): String =
        preferences.getString(customTitleKey(game), null)
            ?.trim()
            ?.takeIf { it.isNotEmpty() }
            ?: game.title
'''
if needle not in text:
    raise SystemExit("Could not find preferences block in GameAdapter.kt")
text = text.replace(needle, insert, 1)

needle = '''            binding.textGameTitle.text = if (game.fileType == "unknown") {
                CitraApplication.appContext.getString(R.string.invalid_rom)
            } else {
                game.title
            }
'''
replacement = '''            binding.textGameTitle.text = if (game.fileType == "unknown") {
                CitraApplication.appContext.getString(R.string.invalid_rom)
            } else {
                displayTitle(game)
            }
'''
if needle not in text:
    raise SystemExit("Could not find game title binding block")
text = text.replace(needle, replacement, 1)

needle = '''        bottomSheetView.findViewById<TextView>(R.id.about_game_title).text = game.title
'''
replacement = '''        val aboutGameTitle = bottomSheetView.findViewById<TextView>(R.id.about_game_title)
        aboutGameTitle.text = displayTitle(game)

        bottomSheetView.findViewById<MaterialButton>(R.id.rename_game_title).setOnClickListener {
            val input = android.widget.EditText(context).apply {
                setSingleLine(true)
                setText(displayTitle(game))
                selectAll()
            }

            MaterialAlertDialogBuilder(context)
                .setTitle("표시 이름 변경")
                .setMessage("AzaharPlus Custom에서만 표시되는 이름입니다. ROM 파일은 변경되지 않습니다.")
                .setView(input)
                .setPositiveButton(android.R.string.ok) { _, _ ->
                    val customTitle = input.text.toString().trim()
                    preferences.edit {
                        if (customTitle.isEmpty()) {
                            remove(customTitleKey(game))
                        } else {
                            putString(customTitleKey(game), customTitle)
                        }
                    }
                    val title = displayTitle(game)
                    holder.binding.textGameTitle.text = title
                    aboutGameTitle.text = title
                }
                .setNeutralButton("기본 이름") { _, _ ->
                    preferences.edit { remove(customTitleKey(game)) }
                    holder.binding.textGameTitle.text = game.title
                    aboutGameTitle.text = game.title
                }
                .setNegativeButton(android.R.string.cancel, null)
                .show()
        }
'''
if needle not in text:
    raise SystemExit("Could not find about-game title assignment")
text = text.replace(needle, replacement, 1)

adapter.write_text(text, encoding="utf-8")

xml = layout.read_text(encoding="utf-8")
needle = '''            <com.google.android.material.button.MaterialButton
                android:id="@+id/delete_cache"
                style="@style/Widget.Material3.Button.TonalButton.Icon"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:contentDescription="@string/delete_shader_cache"
                android:text="@string/delete_shader_cache" />
'''
replacement = needle + '''
            <com.google.android.material.button.MaterialButton
                android:id="@+id/rename_game_title"
                style="@style/Widget.Material3.Button.TonalButton.Icon"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginStart="8dp"
                android:contentDescription="표시 이름 변경"
                android:text="표시 이름 변경" />
'''
if needle not in xml:
    raise SystemExit("Could not find delete_cache button in dialog_about_game.xml")
xml = xml.replace(needle, replacement, 1)
layout.write_text(xml, encoding="utf-8")

g = gradle.read_text(encoding="utf-8")
needle = '        applicationId = "io.github.lime3ds.android"\n'
replacement = '        applicationId = "io.github.floche0.azaharpluscustom"\n'
if needle not in g:
    raise SystemExit("Could not find applicationId in build.gradle.kts")
g = g.replace(needle, replacement, 1)
gradle.write_text(g, encoding="utf-8")

print("AzaharPlus custom title patch applied successfully.")
