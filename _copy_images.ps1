$desktop = [Environment]::GetFolderPath('Desktop')
$src = Join-Path $desktop "ai生成\iamge2\生成"
$dst = "C:\Users\机械革命\.claude\code\my\projects\personal-homepage\images"

New-Item -ItemType Directory -Force -Path $dst | Out-Null

# Select representative images
$selections = @(
    "Fujifilm_Portraits_A_young_woman_sits_cross-legged_on_the_floor_w9ULVGKe.jpg",
    "Fujifilm_Portraits_A_young_woman_with_long_dark_hair_is_holding_a_Zz7V31a0.png",
    "Fujifilm_Portraits_A_young_woman_with_long_dark_hair_is_seated_near_1NUmrhdL.jpg",
    "Film_Portrait_Photography_A_young_woman_with_dark_hair_and_brown_eyes_wears_GzDBqLRZ.png",
    "Film_Portrait_Photography_In_a_neon-lit_urban_setting_a_young_woman_stands_9l2_0ZuU (1).png",
    "Film_Portrait_Photography_In_a_rustic_cafe_a_woman_sits_by_a_window_R-cYU7V4.png",
    "Mountain_Train_Scene_In_a_cinematic_style_a_long_freight_train_led_4d8wg_QE.jpg",
    "Gemini_Generated_Image_m0jpunm0jpunm0jp.png",
    "nanobanana2.jpeg"
)

$copied = @()
foreach ($name in $selections) {
    $srcFile = Join-Path $src $name
    if (Test-Path $srcFile) {
        $ext = [System.IO.Path]::GetExtension($name).ToLower()
        $newName = "work_$([System.IO.Path]::GetFileNameWithoutExtension($name).Substring(0, [Math]::Min(20, [System.IO.Path]::GetFileNameWithoutExtension($name).Length)))$ext"
        Copy-Item $srcFile (Join-Path $dst $newName) -Force
        $copied += @{Original=$name; New=$newName}
    }
}

Write-Output "=== Copied Files ==="
$copied | ForEach-Object { Write-Output "$($_.Original) -> $($_.New)" }
Write-Output "=== Done: $($copied.Count) files ==="
