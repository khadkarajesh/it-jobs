package com.softwarejobs.job.data.model

data class Category(
    val jobs: ArrayList<Job> = ArrayList(),
    val name: String = "",
    val thumbnail: String = ""
)
