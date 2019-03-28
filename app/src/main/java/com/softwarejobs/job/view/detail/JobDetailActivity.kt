package com.softwarejobs.job.view.detail

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.softwarejobs.job.R
import com.softwarejobs.job.data.model.Job
import com.softwarejobs.job.view.adapter.JobDetailAdapter
import kotlinx.android.synthetic.main.activity_job_detail.*

class JobDetailActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_job_detail)

        setSupportActionBar(toolbar)
        supportActionBar!!.setDisplayHomeAsUpEnabled(true)
        supportActionBar!!.setDisplayShowHomeEnabled(true)
        toolbar.setNavigationOnClickListener {
            finish()
        }

        var jobs = intent.getParcelableArrayListExtra<Job>(EXTRA_JOBS)
        var title = intent.getStringExtra(EXTRA_TITLE)

        supportActionBar!!.title = title

        var jobDetailAdapter = JobDetailAdapter(this, jobs)
        rv_job_detail.layoutManager = LinearLayoutManager(this)
        rv_job_detail.adapter = jobDetailAdapter
    }

    companion object {
        private const val EXTRA_JOBS = "jobs"
        private const val EXTRA_TITLE = "title"
        fun start(context: Context, jobs: ArrayList<Job>, title: String) {
            var intent = Intent(context, JobDetailActivity::class.java)
            intent.putParcelableArrayListExtra(EXTRA_JOBS, jobs)
            intent.putExtra(EXTRA_TITLE, title)
            context.startActivity(intent)
        }
    }
}
