#####functions for analysis####

select_window <- function(ee_data,
                          weight_data,
                          lower_window,
                          upper_window,
                          day){
    ee_output <- ee_data |>
        dplyr::filter(Hour >=lower_window & Hour<=upper_window) |>
        dplyr::group_by(cage) |>
        dplyr::summarise(
            ee = mean(ee))|>
        dplyr::mutate(Treatment = stringr::str_remove(
            cage,
            "[:digit:]+$"
        ))
    weight_output <- weight_data |>
        dplyr::filter(Day == day)

    output <- dplyr::left_join(ee_output,
                               weight_output,
                               by ="cage")

    return(output)
}

xy_plot <- function(data_input){
    ggpubr::ggscatter(
        data = data_input,
        x = "bodymass",
        y  = "ee",
        color = "Treatment",
        add = "reg.line"
    )+
        ggpubr::stat_regline_equation(
            ggplot2::aes( label = paste(..eq.label..,
                                        ..rr.label..,
                                        sep = "~~~~"),
                          color = Treatment))
}

lm_calc <- function(dataset){
    dataset$Treatment <- factor(dataset$Treatment)
    if("Vehicle"%in% dataset$Treatment==T){
        dataset$Treatment <- relevel(dataset$Treatment,ref = "Vehicle")

    }
    else{
        dataset$Treatment <- relevel(dataset$Treatment,ref = "veh")
    }
    lm_result <- glm(ee ~ bodymass * Treatment,
                     data = dataset,
                     family = gaussian(link = "identity"))
    return(lm_result)
}

factor_treatment <- function(ee_data){

    ee_data$Treatment <- factor(ee_data$Treatment)
    if("Vehicle"%in% ee_data$Treatment==T){
        ee_data$Treatment <- relevel(ee_data$Treatment,ref = "Vehicle")
    }
    else{
        ee_data$Treatment <- relevel(ee_data$Treatment,ref = "veh")
    }

    return(ee_data)
}

trim_data_study_2 <- function(input_data, meta, min_window, max_window){
    output_data <- input_data |>
        dplyr::filter(elapsed_h >= min_window & elapsed_h <= max_window) |>
        dplyr::group_by(Unique_ID) |>
        dplyr::summarise(ee = mean(ee),
                         feed = mean(feed),
                         bodymass = mean(bodymass),
                         vo2 = mean(vo2),
                         vco2 = mean(vco2)) |>
        dplyr::left_join(meta,
                         by = c("Unique_ID"="Unique_ID"))
    return(output_data)
}

select_window_fi <- function(fi_data,
                             target_day){
    fi_output <- fi_data |>
        dplyr::filter(day == target_day)
    return(fi_output)
}

xy_plot_fi <- function(data_input){
    ggpubr::ggscatter(
        data = data_input,
        x = "bodymass",
        y  = "fi",
        color = "Treatment",
        add = "reg.line"
    )+
        ggpubr::stat_regline_equation(
            ggplot2::aes( label = paste(..eq.label..,
                                        ..rr.label..,
                                        sep = "~~~~"),
                          color = Treatment))
}

lm_calc_fi <- function(dataset){
    dataset$Treatment <- factor(dataset$Treatment)
    if("Vehicle"%in% dataset$Treatment==T){
        dataset$Treatment <- relevel(dataset$Treatment,ref = "Vehicle")
    }
    else{
        dataset$Treatment <- relevel(dataset$Treatment,ref = "veh")
    }
    lm_result <- glm(fi ~ bodymass * Treatment,
                     data = dataset,
                     family = gaussian(link = "identity"))
    return(lm_result)
}

factor_treatment_fi <- function(fi_data){

    fi_data$Treatment <- factor(fi_data$Treatment)
    if("Vehicle"%in% fi_data$Treatment==T){
        fi_data$Treatment <- relevel(fi_data$Treatment,ref = "Vehicle")
    }
    else{
        fi_data$Treatment <- relevel(fi_data$Treatment,ref = "veh")

    }

    return(fi_data)
}
