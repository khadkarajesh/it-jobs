package com.softwarejobs.job.view.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.google.android.material.chip.Chip
import com.google.android.material.chip.ChipGroup
import com.softwarejobs.job.R
import com.softwarejobs.job.data.model.Job
import kotlinx.android.synthetic.main.job_detail_item.view.*

class JobDetailAdapter(var context: Context, var jobs: List<Job>) : RecyclerView.Adapter<JobDetailHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): JobDetailHolder {
        return JobDetailHolder(LayoutInflater.from(parent.context).inflate(R.layout.job_detail_item, parent, false))
    }

    override fun getItemCount(): Int {
        return jobs.size
    }

    override fun onBindViewHolder(holder: JobDetailHolder, position: Int) {
        holder.itemView.company_job_designation.text = jobs[position].title
        holder.itemView.company_name.text = jobs[position].company
        holder.itemView.company_location.text = jobs[position].location

        Glide.with(context)
            .load(R.drawable.ic_company)
            .apply(RequestOptions.circleCropTransform())
            .into(holder.itemView.company_logo)

        jobs[position].skills
            .split("#")
            .filter { !it.isNullOrEmpty() }
            .listIterator()
            .forEach {
                var layoutParams = ChipGroup.LayoutParams(
                    ViewGroup.MarginLayoutParams.WRAP_CONTENT,
                    ViewGroup.MarginLayoutParams.WRAP_CONTENT
                )
                layoutParams.setMargins(4, 4, 4, 4)
                var chip = Chip(context)
                chip.text = it
                chip.layoutParams = layoutParams
                holder.itemView.skills_container.addView(chip)
            }
    }
}

class JobDetailHolder(itemView: View) : RecyclerView.ViewHolder(itemView)