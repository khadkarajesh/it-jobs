package com.softwarejobs.job.view.profile

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.google.firebase.auth.FirebaseAuth
import com.softwarejobs.job.R
import kotlinx.android.synthetic.main.activity_profile.*

class ProfileActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_profile)

        Glide.with(this)
            .load(FirebaseAuth.getInstance().currentUser!!.photoUrl)
            .apply(RequestOptions().circleCrop())
            .into(iv_profile_image)
    }

    companion object {
        fun start(context: Context) {
            var intent = Intent(context, ProfileActivity::class.java)
            context.startActivity(intent)
        }
    }
}
