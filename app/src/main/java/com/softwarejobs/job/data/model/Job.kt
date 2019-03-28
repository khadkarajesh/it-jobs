package com.softwarejobs.job.data.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Job(
    val company: String = "",
    val location: String = "",
    val title: String = "",
    val website: String = "",
    val skills: String = ""
) : Parcelable