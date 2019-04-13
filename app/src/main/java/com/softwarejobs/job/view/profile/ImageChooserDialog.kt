package com.softwarejobs.job.view.profile

import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.softwarejobs.job.R
import kotlinx.android.synthetic.main.fragment_image_chooser.*

class ImageChooserDialog : BottomSheetDialogFragment() {
    companion object {
        const val REQUEST_GALLERY_PHOTO = 300
        fun create(): ImageChooserDialog {
            return ImageChooserDialog()
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_image_chooser, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        tv_capture.setOnClickListener { }
        tv_choose.setOnClickListener {
            chooseFromGallery()
            dismiss()
        }
    }

    private fun chooseFromGallery() {
        var intent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
        intent.type = "image/*"
        activity!!.startActivityForResult(Intent.createChooser(intent, "Select File"), REQUEST_GALLERY_PHOTO)
    }

}