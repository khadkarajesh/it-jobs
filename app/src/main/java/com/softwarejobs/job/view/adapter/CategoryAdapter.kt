package com.softwarejobs.job.view.adapter

import android.app.Activity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.softwarejobs.job.R
import com.softwarejobs.job.data.model.Category
import kotlinx.android.synthetic.main.item_category_view.view.*

class CategoryAdapter(var context: Activity, var jobCategories: List<Category>) :
    RecyclerView.Adapter<CategoryHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CategoryHolder {
        return CategoryHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_category_view, parent, false))
    }

    override fun getItemCount(): Int {
        return jobCategories.size
    }

    override fun onBindViewHolder(holder: CategoryHolder, position: Int) {
        Glide
            .with(context)
            .load(jobCategories[position].thumbnail)
            .placeholder(R.drawable.job_category_placeholder)
            .into(holder.itemView.iv_category_banner)
        holder.itemView.tv_category.text = jobCategories[position].name
        holder.itemView.tv_job_counts.text = "800+jobs"
    }

}

class CategoryHolder(itemView: View) : RecyclerView.ViewHolder(itemView)