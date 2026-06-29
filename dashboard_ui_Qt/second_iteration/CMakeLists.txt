cmake_minimum_required(VERSION 3.16)

project(snerith_5_iteration_2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appsnerith_5_iteration_2
    main.cpp
)

qt_add_qml_module(appsnerith_5_iteration_2
    URI snerith_5_iteration_2
    QML_FILES
    Main.qml
    Battery.qml
    Steer.qml
    Speed.qml
    Setbox.qml
    SettingsCell.qml
    SettingsPopup.qml
    SearchCell.qml
    SearchPopup.qml
    SpeedCell.qml
    F_HeadlightCell.qml
    R_HeadlightCell.qml
    Safetylightcell.qml
    Cameracell.qml
    Aicamera.qml
    ASR.qml
    Batterytemp.qml
    EB_temp.qml
    Hydr_meter.qml
    Motor_temp_high.qml
    icons/top_war.png
    QML_FILES topple.qml
    QML_FILES Slip.qml
    QML_FILES Park.qml
    QML_FILES Warning.qml
    QML_FILES Oil_temp_warning.qml
    QML_FILES Oil_level_warning.qml
    QML_FILES Hydra_low.qml
    QML_FILES Hydra_high.qml
    QML_FILES Solenoid.qml
    icons/camera_on_ai.png
    icons/camera_on.png
    icons/camera_off.png
    QML_FILES Date_time.qml
)
qt_add_resources(appsnerith_5_iteration_2 "icons"
    PREFIX "/"
    FILES
        icons/settings.png
        icons/ai_cam_off.png
        icons/ai_cam_on.png
        icons/asr_off.png
        icons/asr_on1.png
        icons/camera.png
        icons/camera_on.png
        icons/headlight_off.png
        icons/high_beam.png
        icons/low_beam.png
        icons/search.png
        icons/sl_off_2.png
        icons/sl_off.png
        icons/sl_on_2.png
        icons/sl_on.png
        icons/tortoise.png
        icons/snail.png
        icons/rabbit.png
        icons/solenoid_coil.png
        icons/slip_war.png
        icons/sc_b.png
        icons/sc_a.png
        icons/sc_6.png
        icons/sc_5.png
        icons/sc_4.png
        icons/sc_3.png
        icons/sc_2.png
        icons/sc_1.png
        icons/sc.png
        icons/parking_brake.png
        icons/oil_temp_normal.png
        icons/oil_temp_high.png
        icons/oil_level_normal.png
        icons/oil_level_low.png
        icons/motor_temp_high.png
        icons/hyd_mtr_temp_h.png
        icons/hyd_flow_war.png
        icons/emergency.png
        icons/EB_temp_high.png
        icons/cp_warning.png
        icons/cp_6.png
        icons/cp_5.png
        icons/cp_4.png
        icons/cp_3.png
        icons/cp_2.png
        icons/cp_1.png
        icons/battery_temp.png
        icons/top_war.png
        icons/ai_cam_on.png
        icons/ai_cam_off.png
        icons/low_beam_R.png
        icons/low_beam_F.png
        icons/high_beam_R.png
        icons/high_beam_F.png
        icons/headlight_off_R.png
        icons/headlight_off_F.png
        icons/headlight_off.png
        icons/eye_ai_cam_on.png
        icons/eye_ai_cam_off.png
        icons/camera_on_ai.png
        icons/camera_on.png
        icons/camera_off.png


)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appsnerith_5_iteration_2 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appsnerith_5_iteration_2
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsnerith_5_iteration_2
    PRIVATE Qt6::Quick
)

install(TARGETS appsnerith_5_iteration_2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
